From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RESEND PATCH] hid: Drop owner assignment from i2c_driver
Date: Thu, 19 Nov 2015 16:40:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511191639540.20111@pobox.suse.cz>
References: <1447905494-30794-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34998 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758331AbbKSPkH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 10:40:07 -0500
In-Reply-To: <1447905494-30794-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 19 Nov 2015, Krzysztof Kozlowski wrote:

> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.5/i2c-hid. Thanks,

-- 
Jiri Kosina
SUSE Labs

