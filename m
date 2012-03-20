From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 14/20] Input: atmel_mxt_ts - refactor reading object table
Date: Tue, 20 Mar 2012 08:19:02 -0700
Message-ID: <4F689FE6.6020307@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-15-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331640263-18935-15-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>
List-Id: linux-input@vger.kernel.org

Daniel Kurtz wrote:
> Instead of reading each object separately, fetch the whole table in one
> large i2c transaction.  A 6 byte table object requires 10 bytes to read,
> so doing this dramatically reduces overhead.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Yes, this looks very sensible.

Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
