From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] input: touchscreen: add OF match table for ads7846
Date: Mon, 13 Jun 2011 07:24:03 -0600
Message-ID: <BANLkTinAtt2yWc=3VXqdAo4unJbTswKx0g@mail.gmail.com>
References: <1307672920-6261-1-git-send-email-Baohua.Song@csr.com>
 <BANLkTinTGHpyzg69OTcvmsGVLGK3qbZM7g@mail.gmail.com> <BANLkTimxhKWg1QwLEFpGKgg01DRkddmmTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37950 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab1FMNYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 09:24:23 -0400
Received: by pvg12 with SMTP id 12so2108720pvg.19
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2011 06:24:23 -0700 (PDT)
In-Reply-To: <BANLkTimxhKWg1QwLEFpGKgg01DRkddmmTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Thomas Chou <thomas@wytron.com.tw>, devicetree-discuss@lists.ozlabs.org, Zhiwu Song <zhiwu.song@csr.com>, uclinux-dist-devel@blackfin.uclinux.org

On Mon, Jun 13, 2011 at 2:15 AM, Barry Song <21cnbao@gmail.com> wrote:
> Hi Grant,
> Thanks.
>
> 2011/6/13 Grant Likely <grant.likely@secretlab.ca>:
>> On Thu, Jun 9, 2011 at 8:28 PM, Barry Song <Baohua.Song@csr.com> wro=
te:
>>> The current ads7846 has no OF match table. The method used is by ap=
plying a heuristic (of_modalias_node) which tries to name the device in=
 a way that will match an existing device driver.
>>> This patch adds explicit OF match table for ads7846, then the norma=
l device tree match behaviour will always work.
>>> It has been tested on PRIMA2 EVB board of CSR with a SPI's child no=
de like the below:
>>> ts@0 {
>>> =A0 =A0 =A0 =A0compatible =3D "ti,ads7845";
>>> =A0 =A0 =A0 =A0reg =3D <0x0>;
>>> =A0 =A0 =A0 =A0spi-max-frequency =3D <31250>;
>>> =A0 =A0 =A0 =A0interrupts =3D <90>;
>>> };
>>>
>>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> cc: Thomas Chou <thomas@wytron.com.tw>
>>> ---
>>> =A0drivers/input/touchscreen/ads7846.c | =A0 14 ++++++++++++++
>>
>> There should also be documentation for the new binding added to
>> Documentation/devicetree/bindings for the new compatible strings.
>
> Which directory do you think is the best to place this document? or d=
o
> we build a new diretory named
> Documentation/devicetree/bindings/input/touchscreen/ ?
> The dir Documentation/devicetree/bindings seems to be for spi host,
> not for spi clients.

Documentation/devicetree/bindings/input sounds appropriate.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
