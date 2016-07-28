From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC v0 4/8] Input: goodix: use firmware_stat instead of
 completion
Date: Thu, 28 Jul 2016 13:22:32 +0200
Message-ID: <1469704952.6761.142.camel@hadess.net>
References: <1469692512-16863-1-git-send-email-wagi@monom.org>
	 <1469692512-16863-5-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51686 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbcG1LWo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 07:22:44 -0400
In-Reply-To: <1469692512-16863-5-git-send-email-wagi@monom.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Wagner <daniel.wagner@bmw-carit.de>, irina.tirdea@intel.com, octavian.purdila@intel.com

On Thu, 2016-07-28 at 09:55 +0200, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
> Loading firmware is an operation many drivers implement in various
> ways
> around the completion API. And most of them do it almost in the same
> way. Let's reuse the firmware_stat API which is used also by the
> firmware_class loader. Apart of streamlining the firmware loading
> states
> we also document it slightly better.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>

Irina added and tested that feature, so best for her to comment on
this, as I don't have any hardware that would use this feature.

Cheers
