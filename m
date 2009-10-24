From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [lm-sensors] TSC2003 application
Date: Sun, 25 Oct 2009 00:26:08 +0530
Message-ID: <5d5443650910241156k393d5093l4add89a3a7de980b@mail.gmail.com>
References: <13bd74410910210406p18682e43nb28d330d80660f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:43361 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbZJXS4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Oct 2009 14:56:04 -0400
In-Reply-To: <13bd74410910210406p18682e43nb28d330d80660f43@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kirthika varadarajan <kirthikaiitm@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Krithika,

On Wed, Oct 21, 2009 at 4:36 PM, kirthika varadarajan
<kirthikaiitm@gmail.com> wrote:
> Hi,
> =A0I found the driver for TSC2003 in web=A0for =A0Linux 2.6.12 .
> =A0I am using the driver.
> =A0How can i access the touch values in application.
> I2C communication in driver is ok.
>
> When ever i access from application I2C write fails.
>
> Suggest me if there is any sample application for Touch using I2C

Adding linux-input and linux-kernel ML and removing lm-sensors mailing =
list.

TSC2007 driver in latest kernel can be used for TSC2003 chip too. They
are similar chips. You can also find discussion on linux-input ML
archives. Just pass correct i2c board info from your board files if
using ARM like architecture based machine.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
