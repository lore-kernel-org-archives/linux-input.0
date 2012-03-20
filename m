From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 05/20] Input: atmel_mxt_ts - dump mxt_read/write_reg
Date: Tue, 20 Mar 2012 07:43:14 -0700
Message-ID: <4F689782.3000902@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-6-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331640263-18935-6-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
List-Id: linux-input@vger.kernel.org

Daniel Kurtz wrote:
> For verbose on-the-wire debugging.
> Prints DUMP_LEN bytes (in hex) per line.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

I don't think this belongs in the driver. If you want low level i2c
transfer dumps, it should go in i2c subsystem.

Plus, there is the print_hex_dump function for hex dumps.

cheers

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
