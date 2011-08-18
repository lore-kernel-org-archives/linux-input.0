From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 4/6] Input: elantech - work around EC buffer
Date: Thu, 18 Aug 2011 10:50:47 +0800
Message-ID: <CAGS+omBwPxzCpYPL0X9SOGoKf+cjMKtmvAAhcrDwVTCw2vh-WA@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-5-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:37150 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab1HRCvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 22:51:09 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p7I2p8vE019626
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 19:51:09 -0700
Received: from qwf7 (qwf7.prod.google.com [10.241.194.71])
	by hpaq6.eem.corp.google.com with ESMTP id p7I2mZ67017041
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 19:51:07 -0700
Received: by qwf7 with SMTP id 7so1323168qwf.24
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 19:51:07 -0700 (PDT)
In-Reply-To: <1313632629-23603-5-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 9:57 AM, JJ Ding <jj_ding@emc.com.tw> wrote:
> With some EC chips, when we resync due to bad packets, those bad bytes would
> still remain in EC's buffer area. That makes us always get bad data back,
> no matter what.
>
> So shift packet for 1 byte when encounter bad packet, until we get rid of those
> bytes.
>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
