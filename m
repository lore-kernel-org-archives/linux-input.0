From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v6] Fix modifier keys for Redragon Asura Keyboard
Date: Tue, 17 Apr 2018 13:58:35 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804171358270.28129@cbobk.fhfr.pm>
References: <20180416213824.14688-1-rombert@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416213824.14688-1-rombert@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Munteanu <rombert@apache.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 17 Apr 2018, Robert Munteanu wrote:

> This adds a new driver for the Redragon Asura keyboard. The Asura
> keyboard contains an error in the HID descriptor which causes all
> modifier keys to be mapped to left shift. Additionally, we suppress
> the creation of a second, not working, keyboard device.
> 
> Signed-off-by: Robert Munteanu <rombert@apache.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
