From: "DusonLin" <dusonlin@emc.com.tw>
Subject: RE: [PATCH] elan_i2c - Don't require known iap version
Date: Fri, 18 Sep 2015 07:34:24 +0800
Message-ID: <000801d0f1a1$66287320$32795960$@emc.com.tw>
References: <1442437369-23192-1-git-send-email-drake@endlessm.com>	<001b01d0f0e7$77be3490$673a9db0$@emc.com.tw> <CAD8Lp44FPcjwrMq626Avkh=9erjmeoWyzmUC0zWHdNsSQZsNsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:45111 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbIQXeh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 19:34:37 -0400
In-Reply-To: <CAD8Lp44FPcjwrMq626Avkh=9erjmeoWyzmUC0zWHdNsSQZsNsw@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Daniel Drake' <drake@endlessm.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, =?UTF-8?Q?'Jo=C3=A3o_Paulo_Rechi_Vita'?= <jprvita@gmail.com>, linux-input@vger.kernel.org

Hi Daniel,

It is better to change form  "dev_err(&data->client->dev," to " dev_err=
(dev,"

Thanks
duson

-----Original Message-----
=46rom: Daniel Drake [mailto:drake@endlessm.com]=20
Sent: Thursday, September 17, 2015 9:18 PM
To: DusonLin
Cc: Dmitry Torokhov; Jo=C3=A3o Paulo Rechi Vita; linux-input@vger.kerne=
l.org
Subject: Re: [PATCH] elan_i2c - Don't require known iap version

Hi,

On Wed, Sep 16, 2015 at 7:23 PM, DusonLin <dusonlin@emc.com.tw> wrote:
> [Duson] I think it's better to change here " dev_err(dev,"

What do you prefer? dev_warn?

Thanks
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
