From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: multitouch: remove useless last_field_index field
Date: Thu, 7 Mar 2013 15:20:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303071520260.28677@pobox.suse.cz>
References: <1361978595-24225-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38332 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193Ab3CGOUf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Mar 2013 09:20:35 -0500
In-Reply-To: <1361978595-24225-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Feb 2013, Benjamin Tissoires wrote:

> The aim of last_field_index was to detect the end of the report.
> With the introduction of .report(), it is not required anymore to
> detect it on the fly as we can put it in the right place during the
> .report().
> 
> The resulting code path is simpler to read because the terminating
> condition is not evaluated after each field.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
