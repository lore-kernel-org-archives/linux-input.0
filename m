From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Mon, 23 Aug 2010 16:30:17 +0200
Message-ID: <4C7285F9.6050804@euromail.se>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se> <AANLkTinvcUJPgSeLcc-rDF97g_QxZe_W53tCMNGT9wAd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:45638 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720Ab0HWOag (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Aug 2010 10:30:36 -0400
In-Reply-To: <AANLkTinvcUJPgSeLcc-rDF97g_QxZe_W53tCMNGT9wAd@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Ping,
[...]
>> 1) It uses the MT slot protocol

>> 2) It creates two input devices, but only one is useful
> 
> I would like to keep the same wacom_features and usb_device_id
> wacom_ids structures for Bamboo as we did for all the other models,
> i.e., we define one entry for Bamboo although there could be more than
> one logical devices (touch and pen) associated with it.
> 
> This may not make a difference for your Bamboo (a touch only device).
> It would make the code easy to maintain for the other Bamboos (Product
> ID: 0xd1, 0xd2, 0xd3, and 0xd4).
> 
> If you are not sure what I am talking about, please let me know.


The problem I had with this is how that additional input device is presented in
userland. As long as the capabilities are set properly for each input device, I
have no problem using one catch-all match in the device id list.


>> 3) It works well with the synaptics and multitouch X drivers
> 
> I guess it depends on what the plan is for MT support in the userland.
> If our goal is to make the MT X driver generic, there would be no need
> to have a Wacom X drvier for MT (I'd love to go with this route). If
> the MT X driver is only a way to test the kernel driver, we'll have to
> discuss what to do next.


As you no doubt are aware, things are really moving regarding MT support in
Linux. The next Ubuntu release comes with gestures, and the Bamboo works in that
framework too. Real MT through X will become reality within the next six months.
I think it is safe to say that there is no need to add MT to the Wacom driver.

>> 4) It does not work well with the wacom X driver (!)
> 
> This would not be an issue if we (as a team working in the community)
> can answer item 3 above properly.
> 
>> In particular the last point may seem upsetting, but my reasoning is
>> simply that the wacom X driver really supports tablets and not
>> trackpads. I might be convinced otherwise. :-)
> 
> As I said earlier, I would love to see MT supported by a generic X driver.


Then so be it. :-)

Cheers,
Henrik
