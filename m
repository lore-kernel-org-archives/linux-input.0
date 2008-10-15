From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Tue, 14 Oct 2008 22:22:22 -0400
Message-ID: <20081014222222.4260fa48@infradead.org>
References: <20081014113709.5a2f2c2e@infradead.org>
	<1224026249108@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42351 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYJOCWR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 22:22:17 -0400
In-Reply-To: <1224026249108@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Phil Endecott <phil_dubhl_endecott@chezphil.org>
Cc: linux-input <linux-input@vger.kernel.org>

On Wed, 15 Oct 2008 00:17:29 +0100
"Phil Endecott" <phil_dubhl_endecott@chezphil.org> wrote:

> 
> It looks to me as if uhci holds some lock that 8250 needs before it
> can complete.  Now those are both PCI drivers in the same way that
> the last two that seemed to contend were both input drivers (touchpad
> and speaker) [hmm, except that as Dmitry pointed out there's a
> distinction between the platform bus and the serio bus].  Anyway, my
> ignorant suspicion is that there's some lock related to the bus or
> subsystem that they both need.  Maybe something in sysfs?

it does do this. And I know which lock... and I fixed it ;)
Just the patch for this is in Gregkh's tree since it's a change to the
device/sysfs layer and he wanted to carry it via that way.

I can dig that patch out if you want

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
