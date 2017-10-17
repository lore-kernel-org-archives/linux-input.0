From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: add multi-input quirk for GamepadBlock
Date: Tue, 17 Oct 2017 15:24:21 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710171524130.9294@jbgna.fhfr.qr>
References: <1508138951-5018-1-git-send-email-contact@petrockblock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762170AbdJQNYX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Oct 2017 09:24:23 -0400
In-Reply-To: <1508138951-5018-1-git-send-email-contact@petrockblock.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Mueller <contact@petrockblock.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, 16 Oct 2017, Florian Mueller wrote:

> The GamepadBlock game controller adapter needs HID_QUIRK_MULTI_INPUT
> to split it up into two input devices. Without this quirk the
> adapter is falsely recognized as only one device and mixes up the
> inputs of the two connected controllers.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

