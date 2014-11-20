From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: bisected: IR press/release behavior changed in 3.17, repeat events
Date: Thu, 20 Nov 2014 01:30:47 +0100
Message-ID: <546D3637.3010003@openelec.tv>
References: <54679469.1010500@openelec.tv> <20141119195019.GA20784@hardeman.nu> <546D25D7.9050703@openelec.tv> <20141119234539.GB16939@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail03.solnet.ch ([212.101.4.137]:10267 "EHLO mail03.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910AbaKTAax (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2014 19:30:53 -0500
In-Reply-To: <20141119234539.GB16939@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?windows-1252?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, m.chehab@samsung.com, linux-media@vger.kernel.org

Am 20.11.2014 um 00:45 schrieb David H=E4rdeman:
> On Thu, Nov 20, 2014 at 12:20:55AM +0100, Stephan Raue wrote:
>> with kernel 3.17: (you dont see the messages with "toggle 1" here)
>> if i press once and wait:
> Ummm...kinda embarassing...try swapping the order of the scancode and
> toggle lines in the rc6 decoder (drivers/media/rc/ir-rc6-decoder.c).
>
> They're somewhere around line 259, right after the case 32 statement.
>
> case 32:
> 	if ((scancode & RC6_6A_LCC_MASK) =3D=3D RC6_6A_MCE_CC) {
> 		protocol =3D RC_TYPE_RC6_MCE;
>                  scancode &=3D ~RC6_6A_MCE_TOGGLE_MASK;
> 		toggle =3D !!(scancode & RC6_6A_MCE_TOGGLE_MASK);
>
>
many thanks!!! this works :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
