AFNetworking-URITemplate
========================

AFNetworking category for building paths using URI templates and variable expansion.

##Why?
If you have written long and unreadable string concatenations to build complex urls, paths and query parameter strings before, you know why.

Instead of building paths and urls using `NSString` methods:

    [NSString stringWithFormat:@"/api/%@/product/@%/rate/%@?inner=%@", domain, productId, rating, inner];
    
You can now use URI template expansion that are easy to read and understand:
   
    [httpClient expandPath:@"/api/{domain}/product/{product}/rate/{rating}?inner={inner}", domain, productId, rating, inner];
    
##How does it work?
The `AFNetworking-URITemplate` category provides methods for the `AFHTTPClient` class that support URI template expansion of relevant methods.

Two types of template expansions are supported:

* Using a `NSDictonary` - using the name of the URI variable to find a replacement string in the dictionary
* Variable argument list (variadic) - replace the URI variables with the variables provided in the argument list in the same order as they appear. **The list must be nil terminated**

Both methods provide the same level of functionality. Which one to is best to use depends on the context and developer preference.


##Example
The code below show how to make a GET request using `AFHTTPClient` and URI variable expansion.

	@implementation PicasaWebAblumsHTTPClient

	// Get all photos for a specific user and photo album
	- (void)getPhotosForUser:(NSString*)user album:(NSString*)albumId
    	 withCompletionBlock:(void (^)(NSArray *photos))completionBlock
        	       failBlock:(void (^)(NSError *error))failBlock {
  
  		// Create the request
 	 	NSMutableURLRequest *request = [self requestWithMethod:@"GET"
     						  							  path:@"user/{user}/albumid/{albumId}"
												   HTTPHeaders:nil
						 						      HTTPBody:nil
     						  				      URIVariables:user, albumId, nil];
  
  		// Create the operation
  		AFXMLRequestOperation *operation = [PicasaWebAlbumRequestOperation XMLParserRequestOperationWithRequest:request
      			success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {                
        			…
      			}
      			failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParse) {
        			…
			    }];
  
  		// Queue operation
  		[self enqueueHTTPRequestOperation:operation];  
	}
	


##API
An excerpt of the API is provided below. For a full description, check the header file or generated API documentation.

    @interface AFHTTPClient (URITemplate)

	// Create URL request by expanding the provided path using URI 
	// variables in the NSDictonary
	- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
    	                                 path:(NSString*)path
        	                      HTTPHeaders:(NSDictionary*)HTTPHeaders
           	                         HTTPBody:(NSDictionary*)HTTPBody
                             URIVariablesDict:(NSDictionary*)URIVariables;

	// Create URL request by expanding the provided path using URI 
	// variables in the variable argument list
	- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                	     path:(NSString*)path
                              	  HTTPHeaders:(NSDictionary*)HTTPHeaders
                                	 HTTPBody:(NSDictionary*)HTTPBody
                             	 URIVariables:(NSString*)URIVariable, ...;

	// GET
	// Expand using NSDictonary
	- (void)getPath:(NSString*)path
            	success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            	failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
       URIVariablesDict:(NSDictionary*)URIVariables;

	// Expand using variable argument list
	- (void)getPath:(NSString*)path
    	        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        	    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
       	   URIVariables:(NSString*)URIVariable, ...;
	
	// POST
	…
	// PUT
	…
	// DELETE
	…
	// PATCH
	…
	
	@end

##Getting started
Copy the following files to your Xcode project:

* `AFHTTPClient+URITemplate.h`
* `AFHTTPClient+URITemplate.m`
* `NSString+RegexpReplace.h`
* `NSString+RegexpReplace.m`

The `NSString+RegexpReplace` category can be very useful on its own if you need a search-and-replace method with full control over what to replace each match with. Please read the header file or generated API documentation for additional information.

This project is dependent of AFNetworking.


Good luck!

