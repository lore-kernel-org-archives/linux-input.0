From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/2] input: introduce a tougher i8042.reset
Date: Thu, 5 Feb 2009 13:52:29 -0800
Message-ID: <20090205135229.e4d5efc3.akpm@linux-foundation.org>
References: <20090204191540.2d6abd87@infradead.org>
	<20090204191631.21783c62@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57702 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752098AbZBEVww (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Feb 2009 16:52:52 -0500
In-Reply-To: <20090204191631.21783c62@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, arjan@infradead.org, linux-kernel@vger.kernel.org

On Wed, 4 Feb 2009 19:16:31 -0800
Arjan van de Ven <arjan@infradead.org> wrote:

> Some touchpads don't reset right the first time (MSI Wind U-100 for
> example). This patch will retry the reset up to 5 times.

Sigh, real life sucks.  I wonder what the windows driver does.

> In addition, this patch also adds a module parameter to not treat
> reset failures as fatal to the usage of the device. This prevents
> a touchpad failure from also disabling the keyboard....
> 

Is there any reason why we shouldn't just do this all the time?

IOW, is there any benefit in marking the 8042 as dead?

