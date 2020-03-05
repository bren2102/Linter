# Linter Project

The purpose of this project is to create a linter that parses file data and informs of format errors. It's a linter for beginners, i.e. it provides feedback about errors or warning in code little by little.

## Built With

- Ruby

## Instructions

This version of the XML Begginer linter reads the ./doc.xml file included in the project. This XML file linter will evaluate the following syntax correct:

- If the XML prolog exists, must be first in the document.
- If the XML prolog exists, must have the correct structure which includes '?' at the beggining and at the end of the tag
- If there is no closing tag in an inline node
- If the starting and ending tags don't match because are case sensitive. The tag 'Director' is different from the tag 'director'.
- If the XML tags are empty inside < tag > < tag >
- if there are attribute values, these must always be quoted:
- If there is a multiline node, must have starting and ending tag

- Linter passes all tests
![screenshot](/assets/linter_approves.png)

- Linter fails most of the tests
![screenshot](/assets/linter_fails.png)

## Examples

- The XML prolog is optional. If it exists, it must come first in the document.
```xml
  <?xml version="1.0" encoding="UTF-8"?>              [Correct]

  <xml version="1.0" encoding="UTF-8">                [Incorrect]

  <Movies>
  <?xml version="1.0" encoding="UTF-8"?>              [Incorrect]
```
- If the XML prolog exists must have the correct structure at the beggining and the end
```xml
  <?xml version="1.0" encoding="UTF-8"?>              [Correct]

  <xml version="1.0" encoding="UTF-8">                [Incorrect]
```
- In XML, it is illegal to omit the closing tag. All elements must have a closing tag
```xml
  <Year>2015</Year>                                   [Correct]
  
  <Year>2015                                          [Incorrect]
```
- XML tags are case sensitive. The tag 'Director' is different from the tag 'director'.
```xml
  <Director>George .S .Miller</Director>              [Correct]
  
  <Director>George .S .Miller</director>              [Incorrect]
```
- XML tags must contain text inside.
```xml
  <Actor character = "Dr Brand">Michael Caine</Actor> [Correct]
  
  <Actor character = "Dr Brand"></Actor>              [Incorrect]
```
- In XML, the attribute values must always be quoted:
```xml
  <note date="12/11/2007">
  <to>Tove</to>
  <from>Jani</from>
  </note>                                             [Correct]
  
  <note date=12/11/2007>
  <to>Tove</to>
  <from>Jani</from>
  </note>                                             [Incorrect]
```
- Multiline nodes must always have a starting and ending tag
```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
  </note>                                             [Correct]

  <?xml version="1.0" encoding="UTF-8"?>
  <note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>          [Incorrect]
```
## Author

👤 **Brenda Yucra**

- Github: [@bren2102](https://github.com/bren2102) 
- Twitter: [@BrendaYucra2](https://twitter.com/BrendaYucra)
- Linkedin: [Brenda Yucra](https://www.linkedin.com/in/brenda-yucra-51980681/)

## 🤝 Contributing

This project is for learning purposes only, we wont accept contributions, though suggestions are welcome.

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Thanks microverse for this learning opportunity.