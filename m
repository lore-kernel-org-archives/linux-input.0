From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/3] thinkpad_acpi: Wire unused micmute LED to capslock
Date: Fri, 23 Aug 2013 15:18:26 -0300
Message-ID: <20130823181826.GB27893@khazad-dum.debian.net>
References: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
 <1377180132-4933-3-git-send-email-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36452 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565Ab3HWS2i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Aug 2013 14:28:38 -0400
Content-Disposition: inline
In-Reply-To: <1377180132-4933-3-git-send-email-Jason@zx2c4.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, rjw@sisk.pl, len.brown@intel.com, dtor@insightbb.com

On Thu, 22 Aug 2013, Jason A. Donenfeld wrote:
> Thinkpads with a micmute LED do not have a capslock LED. The micmute LED
> is currently not used by any piece of Linux kernel land or user land. It
> seems reasonable to hook it up to caps lock, at least by default, so
> users can have some degree of functionality.

NACK.  This we won't do.  It is a LED misuse, and it will get in the way
when we finally put that LED to its proper use.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
