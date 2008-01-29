From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 1/12] pxa: rename the pxa27x_keyboard to pxa27x_keypad
Date: Tue, 29 Jan 2008 01:26:01 -0500
Message-ID: <200801290126.01530.dtor@insightbb.com>
References: <f17812d70801222316w52070845r123fd9b54bb27b36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxsf09.insightbb.com ([74.128.0.79]:52148 "EHLO
	mxsf09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYA2G0E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 01:26:04 -0500
In-Reply-To: <f17812d70801222316w52070845r123fd9b54bb27b36@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Eric,

On Wednesday 23 January 2008 02:16, eric miao wrote:
> Subject: [PATCH] pxa: rename the pxa27x_keyboard to pxa27x_keypad
> 
> The controller should really be called keypad, and also align
> the naming of functions and structures to use "pxa27x_keypad"
> as prefix, instead of "pxakbd".

Not sure what the difference is... Seems to be a gratuous renaming.

-- 
Dmitry
