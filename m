From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Don't use IRQF_SAMPLE_RANDOM in wm97xx driver
Date: Sat, 11 Apr 2009 17:12:12 -0700
Message-ID: <20090412001212.GA30710@dtor-d630.eng.vmware.com>
References: <1239357192-27726-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1239357192-27726-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:2381 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZDLAMV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Apr 2009 20:12:21 -0400
Content-Disposition: inline
In-Reply-To: <1239357192-27726-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Apr 10, 2009 at 10:53:12AM +0100, Mark Brown wrote:
> The input core will add entropy to the pool without this flag being
> used.
> 

Apllied this and the atmel driver one, thank you.

-- 
Dmitry
