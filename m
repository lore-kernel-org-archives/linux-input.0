From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Wed, 17 Dec 2014 10:06:52 +0000
Message-ID: <549155BC.4080803@itdev.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk> <54905AD7.4070205@itdev.co.uk> <54905F00.4020107@collabora.co.uk> <54906031.8020309@itdev.co.uk> <54906285.3060907@collabora.co.uk> <549066D4.7000302@itdev.co.uk> <54906FEB.7060702@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:26703 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751915AbaLQKGz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 05:06:55 -0500
In-Reply-To: <54906FEB.7060702@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 16/12/14 17:46, Javier Martinez Canillas wrote:
> On 12/16/2014 06:07 PM, Nick Dyer wrote:
>> I had been keeping them separate on the basis that we don't want changes to
>> support new T100 features to cause regressions in the old T9 handling. But
>> there is a fair amount of duplication as you say, probably worth addressing.
> 
> Yeah but if there are regressions I think we should address those instead of
> duplicating code, to make the driver more maintainable in the long term.

True enough. We will have to be careful to test on both types of device.
