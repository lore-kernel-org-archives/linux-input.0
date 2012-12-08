From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 1/1] Input: add driver for Cypress APA I2C Trackpad
Date: Sat, 8 Dec 2012 13:39:35 +0100
Message-ID: <20121208123935.GA3147@polaris.bitmath.org>
References: <1341959357-14691-1-git-send-email-bleung@chromium.org>
 <1354754899-26701-1-git-send-email-bleung@chromium.org>
 <1354754899-26701-2-git-send-email-bleung@chromium.org>
 <20121206145911.GA9882@polaris.bitmath.org>
 <CANLzEkttUr80DX1z-QfqKq8VM0G25m2bTADwU5pUBiB4HAU0Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:54556 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135Ab2LHMhS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Dec 2012 07:37:18 -0500
Content-Disposition: inline
In-Reply-To: <CANLzEkttUr80DX1z-QfqKq8VM0G25m2bTADwU5pUBiB4HAU0Jw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Olof Johansson <olofj@chromium.org>, Dudley Du <dudl@cypress.com>

Hi Benson,

> I have applied your patch, but I found I still need this line in my
> driver, otherwise, there are no ABS type event supported. Should the
> core set this bit as well since it's certainly going to be dealing
> with ABS data?
> 
> __set_bit(EV_ABS, input->evbit);

Yes, that would make sense, I will look into it.

> Otherwise, it works great on my Chromebook trackpad here.

Great,
Henrik
