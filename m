From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: cp2112: fix sleep-while-atomic regression
Date: Tue, 31 Jan 2017 13:06:05 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701311305530.25515@cbobk.fhfr.pm>
References: <20170130102235.3691-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46029 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdAaMHD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 07:07:03 -0500
In-Reply-To: <20170130102235.3691-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 30 Jan 2017, Johan Hovold wrote:

> These patches fix a sleep-while-atomic and an error-handling issue
> introduced by a patch that went into 4.9.

Applied, thanks a lot for fixing this up.

-- 
Jiri Kosina
SUSE Labs

