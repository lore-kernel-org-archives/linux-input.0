From: Philippe Coval <rzr@gna.org>
Subject: Re: [PATCH v3] usbtouchscreen: add option for inverting X or Y axis
Date: Sat, 10 Oct 2015 00:21:38 +0200
Message-ID: <56183DF2.1010503@gna.org>
References: <1436782503-9749-1-git-send-email-rzr@gna.org> <1438035361-9157-1-git-send-email-rzr@gna.org> <20150727222823.GF3613@dtor-ws>
Reply-To: rzr@gna.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150727222823.GF3613@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philippe Coval <rzr@gna.org>, bernhard.bender@bytecmed.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 7/28/15, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 12:16:01AM +0200, Philippe Coval wrote:
>> Invert Y is needed (together with swap XY) for some touchscreens,
>> at least for some of them :
>>
>> - CarTft 8in4 (type=eGalax, USB=0eef:0001)
>> - LeadingTouch
>>
>> Since there is not guarantee that
>> those above devices will all behave the same,
>> it's safer to configure them userland using udev rules.
>>
>> This way is safer than hardcoding options per "recognized" model,
>> and possible regressions will be avoided in a first place.
>
> Does the following still work?

Hi,

First apologies for delay.

Actually, I wished someone else will give you feedback earlier
since I don't have this screen anymore.

Anyway I know it worked well once applied to some 4.2 rc version.
(and also merged downstream in tizen on 3.14)

Doesn't the change look trivial ?
Do we assume it will work on later versions too ?

For the record here is the reference of the mentioned touchscreen :

MM500
http://www.cartft.com/catalog/il/477

I've contacted vendor, and It's not for sale anymore
(under this brand at least).

Regards
