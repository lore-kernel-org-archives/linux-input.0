From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: synaptics - use firmware data for Cr-48
Date: Thu, 19 Jul 2012 15:14:39 +0200
Message-ID: <20120719131439.GA278@polaris.bitmath.org>
References: <1342606923-9997-1-git-send-email-cywang@chromium.org>
 <5006D86C.7030208@canonical.com>
 <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:41131 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab2GSNNh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 09:13:37 -0400
Content-Disposition: inline
In-Reply-To: <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chung-Yih Wang =?utf-8?B?KOeOi+W0h+aHvyk=?= <cywang@google.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>    Thanks for your great comments. You are right, it is impossible to get
>  correct finger tracking if both fingers are moving. However, we think it
> still worth to have the firmware tracking of the fingers as they could
> perform well for most one-stationary-one-moving cases. This will be good
> enough for the one-stationary-one-moving gestures we want to provide on
> Cr-48. And that's why we want to make the patch specific to Cr-48.

If one finger is stationary, it is trivial to find out where the other
finger is using the available semi-mt data.

The general feeling about this patch is that it is very similar to
where we started off two years ago. The problems we saw then led to
the implementation of the semi-mt protocol. I doubt things have
changed much since then.

Thanks,
Henrik
