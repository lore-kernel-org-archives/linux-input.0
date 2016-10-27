From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: Re: [PATCH 4/4] Input: goodix - Support interchanging x and y
 coordinates in hardware
Date: Thu, 27 Oct 2016 12:42:06 -0500
Message-ID: <317acd32-f363-3b2b-9e30-106d5b335342@ti.com>
References: <20161020195917.20051-1-fcooper@ti.com>
 <20161020195917.20051-5-fcooper@ti.com>
 <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
 <1477564471.2458.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477564471.2458.11.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Rob Herring <robh@kernel.org>
Cc: dmitry.torokhov@gmail.com, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com
List-Id: linux-input@vger.kernel.org



On 10/27/2016 05:34 AM, Bastien Nocera wrote:
> On Wed, 2016-10-26 at 18:18 -0500, Rob Herring wrote:
>> On Thu, Oct 20, 2016 at 02:59:17PM -0500, Franklin S Cooper Jr wrote:
>>>
> <snip>
>> I'm not sure I follow why existing properties don't cover this.
> 
> Me neither. I certainly don't understand why the driver can't mangle
> the data from the touchscreen all it wants. It's not like user-space is
> talking to the touchscreen directly.
> 
Sorry the above could of been clearer.

Lets ignore talking about X and Y axis for a little bit since that
really depends on the default touchscreen config values and the way it
is mounted on the touchscreen. Now lets say when your interacting with
the touchscreen the touchscreen controller outputs a max value of 1280
when moving your finger horizontally and 800 when moving your finger
vertically.

<-1280->
------
|    |  ^
|    |  |
|    | 800
|    |  |
------  V

So no matter what your horizontal range is 0-1280 and your vertical
range is 0-800. Now based on the above diagram you can see that usually
you want the longer side to have a higher resolution. So you may want a
vertical range of 0-1280 and a horizontal range from 0-800 instead.

So lets add labels to the original diagram and assume that the x and y
axis from the driver/user-space perspective is as follows.
<-1280-> (X)
------
|    |  ^
|    |  |
|    | 800  (Y)
|    |  |
------  V

The only thing the driver (software) has the ability to do is change the
"orientation".

<-1280-> (Y)
------
|    |  ^
|    |  |
|    | 800  (X)
|    |  |
------  V

However, this doesn't change the resolution ie range of values in the
horizontal and vertical direction the touch screen controller will
report. Only the hardware can determine the resolution it will use. The
interchange bit I set essentially swaps the range that the controller is
currently programmed to use which in my first diagram the horizontal
range was 0-1280 and my vertical range is 0-800. So by setting this
interchange bit in hardware the horizontal range will now be 0-800 while
the vertical range will be 0-1280 which is what we want.

Does this clarify things? I messed up the second diagram in my commit
message which is probably what caused the confusion.
