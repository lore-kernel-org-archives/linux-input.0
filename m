From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] hid: hid-sensor-hub: Move NULL check to beginning
Date: Wed, 21 Nov 2012 12:42:51 +0000
Message-ID: <20121121124251.7bc7102b@pyramind.ukuu.org.uk>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
	<1353478830-23788-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34228 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab2KUMiK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 07:38:10 -0500
In-Reply-To: <1353478830-23788-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, jic23@kernel.org, patches@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wed, 21 Nov 2012 11:50:30 +0530
Sachin Kamat <sachin.kamat@linaro.org> wrote:

> This avoids a possible NULL pointer dereference error when report
> is NULL.

This is wrong. Please see the patch I sent a while ago - it can't be
NULL, the check just needs removing.
