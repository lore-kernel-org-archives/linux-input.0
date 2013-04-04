From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: wiimote: use unique battery names
Date: Thu, 4 Apr 2013 09:43:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304040943350.30938@pobox.suse.cz>
References: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53002 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763918Ab3DDHny (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Apr 2013 03:43:54 -0400
In-Reply-To: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 2 Apr 2013, David Herrmann wrote:

> Battery device names must be unique, otherwise registration fails if
> multiple Wii Remotes are connected.

Applied the series, thanks David.

-- 
Jiri Kosina
SUSE Labs
