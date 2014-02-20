From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: Questions about the documentation/specification of Linux
 ForceFeedback input.h
Date: Thu, 20 Feb 2014 09:52:20 +0100
Message-ID: <CADbOyBQhHExwBgfuhcYZscZoi4o-cTqs6TOqDj6Z4Uzpm6TgWA@mail.gmail.com>
References: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>
	<52FECB6E.4000004@iki.fi>
	<CADbOyBQ1iA_7c4Rik7nBPvqAwVouoQDL33L3PE2RiVLnmFz1YQ@mail.gmail.com>
	<52FF73D7.6030108@iki.fi>
	<CADbOyBROrPtqptnnh+Xtb9+X7EhGMudaHRai2wQLga5vca=rxg@mail.gmail.com>
	<52FFF276.1060704@iki.fi>
	<CADbOyBSYeCLLa=WE72dwNpsexq7gDsL4iJiOfrpKgLOp3+A7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:58438 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbaBTIwV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 03:52:21 -0500
Received: by mail-ve0-f178.google.com with SMTP id oy12so1563679veb.37
        for <linux-input@vger.kernel.org>; Thu, 20 Feb 2014 00:52:20 -0800 (PST)
In-Reply-To: <CADbOyBSYeCLLa=WE72dwNpsexq7gDsL4iJiOfrpKgLOp3+A7tA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Johann Deneux <johann.deneux@gmail.com>, linux-input@vger.kernel.org

Another question:
There is written on /include/uapi/linux/input.h:1058 :
    "@phase: 'horizontal' shift"
where 'horizontal' most likely means time dimension, not phase of the
waveform, right?


Elias
