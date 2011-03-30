From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 1/3] input/touchscreen: Synaptics RMI4 Touchscreen Driver
Date: Wed, 30 Mar 2011 14:08:43 -0700
Message-ID: <4D939BDB.6050304@synaptics.com>
References: <1301446249-13646-1-git-send-email-cheiny@synaptics.com> <1301446249-13646-2-git-send-email-cheiny@synaptics.com> <20110330080223.GB2232@pengutronix.de> <4D937814.5010604@synaptics.com> <20110330194412.GA26261@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110330194412.GA26261@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <WManson@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

On 03/30/2011 12:44 PM, Wolfram Sang wrote:
> * PGP Signed by an unknown key: 03/30/2011 at 11:44:12 AM
> On Wed, Mar 30, 2011 at 11:36:04AM -0700, Christopher Heiny wrote:
>> On 03/30/2011 01:02 AM, Wolfram Sang wrote:
>>>> Old Signed by an unknown key: 03/30/2011 at 12:02:23 AM
>>> Hi,
>>>
>>>> +	retval = rmi_register_sensor(&instancedata->rmiphysdrvr, platformdata->perfunctiondata);
>>>> +	if (retval) {
>>>> +		dev_err(&client->dev, "%s: Failed to Register %s sensor drivers\n",
>>>> +				__func__, instancedata->rmiphysdrvr.name);
>>>> +		i2c_set_clientdata(client, NULL);
>>>
>>> I originally just wanted to say that this line can be removed. Then I
>>> remembered that I already sent a patch for a similar driver in staging
>>> (dc7b202a4ee6cb686e2bbef80c84443f43ec91bd). The staging driver looks in
>>> a better shape to me. Do you know about it?
>>
>> That call is required in order to register the sensor device on the
>
> I meant the last line, setting clientdata to NULL is not needed anymore.

D'oh!  OK, we'll remove that.


>> I'm afraid I can't locate the commit you specified.
>
> Direct search failed for me, too, but here is the link:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dc7b202a4ee6cb686e2bbef80c84443f43ec91bd

Thanks - yes, I looked at that one when it was first submitted.

>> I do find a driver in staging/ste_rmi4/synaptics_i2c_rmi4.[ch] - is that the
>> one?
>
> Yes, I meant this one. Looks a bit better from a glimpse; no '#if 0'-blocks,
> much less printk. I just wondered how these two are related and if it makes
> sense to join efforts here.

Yah, the ste_rmi4 patch is a lot tidier in those terms.  One of the 
issues we're facing is that not only are we developing our code for 
kernel.org submission, we also have to support various in-development 
customer projects at the same time out of the same codebase.  The #ifs 
and printks tend to slip in under the radar in that process - we'll work 
on vetting this better during the patch preparation process.

The ste_rmi4 patch and our work share a common ancestor in some older 
reference code that we distributed in 2009.  There's nothing 
particularly wrong with the ste_rmi4 patch in and of itself, but for our 
purposes going forward we require a more generic and modular structure. 
  In particular, we needed to separate the communications code from the 
functional implementation code, allow multiple RMI4 sensors on a single 
system (possibly using different communications mechanisms) and to 
enable future modular loading of individual function implementations. 
Along with some other features, Dmitry required implementing an rmi bus, 
and we've been proceeding with that design.

It does make sense to join efforts going forward.  Any contributions you 
would like to make would be happily accepted.  Our current architecture 
is pretty much committed as the direction going forward (both for 
Synaptics and for kernel.org), so I think the most sensible thing is to 
use the recent Synaptics patch as the basis for that.

					Chris
