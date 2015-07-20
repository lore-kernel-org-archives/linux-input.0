From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH RESENT] Input: elan_i2c - enable ELAN0600 acpi panels
Date: Mon, 20 Jul 2015 11:30:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507201129390.1141@pobox.suse.cz>
References: <1437158979-12381-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:36888 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752560AbbGTJaT (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Mon, 20 Jul 2015 05:30:19 -0400
In-Reply-To: <1437158979-12381-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Alessio Treglia <alessio@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 17 Jul 2015, Benjamin Tissoires wrote:

> ELAN0600 seems to work just fine in mouse emulation mode through i2c-hid,
> but to have full raw touch support we need to register it in elan_i2c.ko
> 
> Reported-and-tested-by: Alessio Treglia <alessio@debian.org>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs
