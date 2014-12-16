From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Tue, 16 Dec 2014 16:16:23 +0000
Message-ID: <54905AD7.4070205@itdev.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:50479 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbaLPQQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 11:16:31 -0500
In-Reply-To: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 15/12/14 10:39, Javier Martinez Canillas wrote:
> There are different multi-touch protocols used by Atmel maXTouch touchscreen
> chips. Old chips use the T9 multi-touch object type while newer chips use the
> T100 multi-touch object type. The Atmel touch driver currently only supports
> the former so this series add support for the later.
> 
> The series is composed of the following patches:
> 
> Nick Dyer (1):
>   Input: atmel_mxt_ts - Implement support for T100 touch object

Hi Dmitry-

I posted an updated version of this patch on 9th December and would prefer
you apply that rather than this version, since it contains some useful
additional work.

A link to it:
http://www.spinics.net/lists/kernel/msg1885519.html

cheers

Nick
