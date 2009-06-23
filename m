From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.{28,30} Keyboard not working on oldish machine
Date: Tue, 23 Jun 2009 10:42:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906231038500.7457@wotan.suse.de>
References: <20090613230842.GA18347@gallifrey> <4A349B67.1070603@zytor.com> <20090614122734.GA1499@gallifrey> <alpine.LRH.2.00.0906161126330.31685@twin.jikos.cz> <20090617193442.GA31944@gallifrey> <alpine.LNX.2.00.0906180126260.7457@wotan.suse.de>
 <20090620120357.GA11272@gallifrey> <20090622194605.GA25820@gallifrey>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35553 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbZFWImM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 04:42:12 -0400
In-Reply-To: <20090622194605.GA25820@gallifrey>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, 22 Jun 2009, Dr. David Alan Gilbert wrote:

> > Yes, with i8042.noaux it works; dmesg snippet included below.
> > And in reply to hpa, it doesn't have a mouse port.
> I saw you also asked for a dmidecode -t system dmidecode says the 
> machine has 'No SMBIOS nor DMI entry point'.

Hmm, that means that there is no easy way to identify your particular 
machine (which apparently has somewhat broken AUX i8042 port) in run-time 
for quirk to be applied. I am afraid you'll need to live with specifying 
the command-line kernel parameter on this machine.

-- 
Jiri Kosina
SUSE Labs
