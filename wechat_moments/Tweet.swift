//
//  Tweet.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation

struct Tweet: Codable {
    var content : String?
    let images : [Image]?
    let sender : Sender?
    let comments : [Comment]?
}

struct Image: Codable {
    let url : String
}

struct Sender : Codable {
    let username : String
    let nick: String
    let avatar: String
}

struct Comment: Codable {
    let content : String
    let sender : Sender
}
let momentAll = """
[
  {
    "content": "沙发！",
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/001.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/002.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/003.jpeg"
      }
    ],
    "sender": {
      "username": "cyao",
      "nick": "Cheng Yao",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg"
    },
    "comments": [
      {
        "content": "Good.Good.Good.Good.Good.Good.Good.Good.Good.Good.Good.⏰",
        "sender": {
          "username": "leihuang",
          "nick": "Lei Huang",
          "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/002.jpeg"
        }
      },
      {
        "content": "Like it too",
        "sender": {
          "username": "weidong",
          "nick": "WeiDong Gu",
          "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/003.jpeg"
        }
      }
    ]
  },
  {
    "sender": {
      "username": "xinge",
      "nick": "Xin Ge",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/000.jpeg"
    }
  },
  {
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/004.jpeg"
      }
    ],
    "sender": {
      "username": "yangluo",
      "nick": "Yang Luo",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/004.jpeg"
    }
  },
  {
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/005.jpeg"
      }
    ],
    "sender": {
      "username": "jianing",
      "nick": "Jianing Zheng",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/005.jpeg"
    }
  },
  {
    "error": "losted"
  },
  {
    "content": "Unlike many proprietary big data processing platform different, Spark is built on a unified abstract RDD, making it possible to deal with different ways consistent with large data processing scenarios, including MapReduce, Streaming, SQL, Machine Learning and Graph so on. To understand the Spark, you have to understand the RDD. ",
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/006.jpeg"
      }
    ],
    "sender": {
      "username": "weifan",
      "nick": "Wei Fan",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/006.jpeg"
    }
  },
  {
    "content": "这是第二页第一条",
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/007.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/008.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/009.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/010.jpeg"
      }
    ],
    "sender": {
      "username": "xinguo",
      "nick": "Xin Guo",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/007.jpeg"
    },
    "comments": [
      {
        "content": "Good.",
        "sender": {
          "username": "yanzili",
          "nick": "Yanzi Li",
          "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/008.jpeg"
        }
      },
      {
        "content": "Like it too",
        "sender": {
          "username": "jingzhao",
          "nick": "Jing Zhao",
          "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg"
        }
      }
    ]
  },
  {
    "sender": {
      "username": "hengzeng",
      "nick": "Niang Niang",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/000.jpeg"
    }
  },
  {
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/011.jpeg"
      }
    ],
    "sender": {
      "username": "jizhang",
      "nick": "Jian Zhang",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/002.jpeg"
    }
  },
  {
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/012.jpeg"
      }
    ],
    "sender": {
      "username": "yanzi",
      "nick": "Yanzi Li",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/003.jpeg"
    }
  },
  {
    "error": "illegal"
  },
  {
    "error": "WTF"
  },
  {
    "error": "WOW"
  },
  {
    "content": "As a programmer, we should as far as possible away from the Windows system. However, the most a professional programmer, and very difficult to bypass Windows this wretched existence but in fact very real, then how to quickly build a simple set of available windows based test environment? See Qiu Juntao's blog. ",
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/013.jpeg"
      }
    ],
    "sender": {
      "username": "jianing",
      "nick": "Jianing Zheng",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/004.jpeg"
    },
    "comments": [
      {
        "content": "Good.",
        "sender": {
          "username": "cyao",
          "nick": "Cheng Yao",
          "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/005.jpeg"
        }
      }
    ]
  },
  {
    "content": "第9条！",
    "images": [
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/014.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/015.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/016.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/016.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/017.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/018.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/019.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/020.jpeg"
      },
      {
        "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/021.jpeg"
      }
    ],
    "sender": {
      "username": "jianing",
      "nick": "Jianing Zheng",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/006.jpeg"
    },
    "comments": []
  },
  {
    "content": "第10条！",
    "sender": {
      "username": "xinguo",
      "nick": "Xin Guo",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/007.jpeg"
    },
    "comments": []
  },
  {
    "content": "楼下保持队形，第11条",
    "sender": {
      "username": "yanzi",
      "nick": "Yanzi Li",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/008.jpeg"
    }
  },
  {
    "content": "第12条",
    "sender": {
      "username": "xinguo",
      "nick": "Xin Guo",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg"
    }
  },
  {
    "content": "第13条",
    "sender": {
      "username": "yanzili",
      "nick": "Yanzi Li",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/002.jpeg"
    }
  },
  {
    "content": "第14条",
    "sender": {
      "username": "xinguo",
      "nick": "Xin Guo",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/003.jpeg"
    }
  },
  {
    "unknown error": "STARCRAFT2"
  },
  {
    "content": "- The data json will be hosted in Nibs or storyboards are prohibited- Implement cache mechanism by you own if needed- Unit tests is appreciated.- Functional programming is appreciated- Deployment Target should be 7.0- Utilise Git for source control, for git log is the directly evidence of the development process- Utilise GCD for multi-thread operation- Only binary, framework or cocopods dependency is allowed. do not copy other developer's source code(*.h, *.m) into your project- Keep your code clean as much as possible",
    "sender": {
      "username": "hengzeng",
      "nick": "Huan Huan",
      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/004.jpeg"
    }
  }
]
"""









