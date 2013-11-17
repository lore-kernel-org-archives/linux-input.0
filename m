From: simon@mungewell.org
Subject: Re: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Sun, 17 Nov 2013 14:46:32 -0500
Message-ID: <b5aa869c12a432d275c51f9130ba697b.squirrel@mungewell.org>
References: <1384682880-5960-1-git-send-email-sven@narfation.org>
    <1384717101-7027-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:60990 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab3KQTqe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 14:46:34 -0500
In-Reply-To: <1384717101-7027-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Sven Eckelmann <sven@narfation.org>


>  drivers/hid/hid-sony.c | 53
> +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 11 deletions(-)

Doesn't this miss patching Kconfig (previous changes were reverted).
Simon

