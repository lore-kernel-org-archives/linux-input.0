From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH] add antec-branded soundgraph imon devices to hid_ignore_list
Date: Wed, 28 Jan 2009 15:31:05 -0500
Message-ID: <200901281531.06045.jarod@redhat.com>
References: <200901281049.28799.jarod@redhat.com> <alpine.LNX.1.10.0901282123520.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:33354 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010AbZA1UbL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 15:31:11 -0500
In-Reply-To: <alpine.LNX.1.10.0901282123520.5377@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wednesday 28 January 2009 15:24:18 Jiri Kosina wrote:
> On Wed, 28 Jan 2009, Jarod Wilson wrote:
> > hid_ignore_list additions for the Antec-branded SoundGraph iMon VFD and
> > LCD devices (0x15c2:0x0044 and 0x0045).
>
> lirc is capable of handling these as well, right?

Correct. I added support for these to lirc a few weeks back after
picking up one of the 0045 devices myself.

-- 
Jarod Wilson
jarod@redhat.com

