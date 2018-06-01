From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Fri, 1 Jun 2018 21:03:21 +0200
Message-ID: <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601184330.GD222005@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


>> However, I interpret a firmware that send (confidence 1, tip switch 1)
>> and then (confidence 0, tip switch 0) a simple release, and the
>> confidence bit should not be relayed.
> This unfortunately leads to false clicks: you start with finger, so
> confidence is 1, then you transition the same touch to palm (use your
> thumb and "roll" your hand until heel of it comes into contact with the
> screen). The firmware reports "no-confidence" and "release" in the same
> report and userspace seeing release does not pay attention to confidence
> (i.e. it does exactly "simple release" logic) and this results in UI
> interpreting this as a click. With splitting no-confidence
> (MT_TOOL_PALM) and release event into separate frames we help userspace
> to recognize that the contact should be discarded.
This is in part why I objected to this patch on August 11th, 2017. 
Logically, the confidence state is a property of a contact, not a new 
type of contact. Trying to use it in any other way is bound to lead to 
confusion.

Henrik
