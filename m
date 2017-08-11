From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Fri, 11 Aug 2017 10:29:07 +0200
Message-ID: <c1a6ca9c-5f4d-cc9e-fc36-71d7d6aff640@bitmath.org>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <5528ad84-9b42-8826-abb1-1aef06876284@bitmath.org>
 <CAKdAkRRRo-Xz5O7+gVQcAH5=PnEgwhDx4eYvyBZe7Qbves21kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRRRo-Xz5O7+gVQcAH5=PnEgwhDx4eYvyBZe7Qbves21kg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> The meaning of confidence is literally "contact is too large to be a
> finger", so it is not touch state, but really tool identity. We do
> allow tool identity to change over time.
What I am arguing is rather that since "palm" is a property, just like 
contact size, there should be no need to confuse that property with the 
touch state, which is, as you state, what happens in userland when the 
tool type is modified. Using a different event for the palm property 
ought to remove that confusion.

> The additional state is simply because we have never updated the tool
> type on release events and userspace is not expecting it and is likely
> to ignore any data in the slot that is accompanied with
> ABS_TRACKING_ID == -1. So we synthesize an extra event to have
> distinct tool change and release.

We update all other properties of a contact freely at release, so logically there is no good reason to treat palm, the binary version of max contact size, differently.
  

> Mostly because with BTN_TOOL_PALM we are not able to decide which
> contact is turning into palm. Also, other drivers (RMI) use
> MT_TOOL_PALM and I would like to report palm state in unified way.
Precedent certainly matters, but in this case, I think the modification 
promises problems down the road. I would rather suggest to add a new 
binary palm property, with the precise meaning "contact size = max 
contact size", and take it from there. I dont mind writing a patch for 
it if you agree.

Henrik
