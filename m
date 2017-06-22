From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v5] HID: Add driver for Retrode2 joypad adapter
Date: Thu, 22 Jun 2017 14:46:08 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706221445550.30709@cbobk.fhfr.pm>
References: <20170620161337.14492-1-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52993 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752332AbdFVMqS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Jun 2017 08:46:18 -0400
In-Reply-To: <20170620161337.14492-1-hadess@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 20 Jun 2017, Bastien Nocera wrote:

> This driver does 2 things:
>  - Apply the MULTI_INPUT quirk to create separate joypad device nodes
>    for each one of the 4 connectors.
>  - Rename the input devices so that their names are different, and allow
>    users to recognise which device corresponds to which physical port,
>    including the SNES (Mario Paint) Mouse.

Applied to for-4.13/retrode.

-- 
Jiri Kosina
SUSE Labs

