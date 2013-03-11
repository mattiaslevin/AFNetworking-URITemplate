AFNetworking-URITemplate
========================

AFNetworking category for building paths using URI templates and variable expansion.

##Why?
If you hade to write unreadable string concatinations to build complex urls, paths and query parameter strings before you know why.

Instead of building paths and urls using `NSString` methods:

    NSString *path = [NSString stringWithFormat:@"/api/%@/product/@%/rate/%@", domain, productId, rating];
    
You can now use URI template epansion that are easy to read and understand:
   
    NSString *path = [httpClient expandPath:@"/api/{domain}/product/{product}/rate/{rating}", domain, productId, rating];
    
##How does it work?
The `AFNetworking-URITemplate` category provides overloaded methods for the `AFHTTPClient` class that support URI template expansion of all relevant methods.

Two types of URI template expansions are supported:

* Using a `NSDictonary` - using the name of the URI variable to find a replacement string in the dictonary
* Variable argument list (variadic) - replace the URI variables with the variables provided in the argument list in the same order as they appear

Both methods provide the same level of functionality. Which one to is best to use dependends on the context and developer preference.


##Example
The code below show how to use make a POST using `AFHTTPClient` and URI variable explansion.

    Add example...


##API
An exceprt of the API is provided below. For a full description, check the header file or generated API documentation.

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
	...
	// PUT
	...
	// DELETE
	...
	// PATCH
	...
	
	@end

##Getting started
Copy the following files to your Xcode project:

* `AFHTTPClient+URITemplate.h`
* `AFHTTPClient+URITemplate.m`
* `NSString+RegexpReplace.h`
* `NSString+RegexpReplace.m`

The `NSString+RegexpReplace` category can be very usefull on its own if you need a search-and-replace method with full control over what to replace each match with. Please read the header file or generated API documentation for additional information.

This project is dependent of AFNetworking.


Good luck!

