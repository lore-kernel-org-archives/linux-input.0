From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Thu, 09 Dec 2010 09:45:33 -0800
Message-ID: <1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	 <4D00800E.7050004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:55339 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0LIRpu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 12:45:50 -0500
In-Reply-To: <4D00800E.7050004@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arve@android.com

On Thu, 2010-12-09 at 12:36 +0530, Trilok Soni wrote:

> > +static char *keycaps = "--qwerty";
> > +#undef MODULE_PARAM_PREFIX
> > +#define MODULE_PARAM_PREFIX "board_trout."
> > +module_param_named(keycaps, keycaps, charp, 0);
> 
> I would like to know what is the use of this param?

No idea .. It was part of Google's implementation ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

