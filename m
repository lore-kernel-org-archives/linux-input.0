From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 04/15] Input: atmel_mxt_ts - implement device tree support
Date: Thu, 24 Jul 2014 16:10:22 +0100
Message-ID: <53D121DE.8070401@itdev.co.uk>
References: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk> <1404399697-26484-5-git-send-email-nick.dyer@itdev.co.uk> <53D02AF8.5000100@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53D02AF8.5000100@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-input@vger.kernel.org

On 23/07/14 22:36, Stephen Warren wrote:
> Hmm. It looks like the version of this patch that was actually applied
> varies quite a bit from what was posted, in particular in the
> implementation and call site of mxt_parse_dt(). It'd be nice if the
> commit log had been adjusted to mention this, so it didn't look like *I*
> caused all those compile errors and warnings that the 0-day builder just
> found:-(

Apologies for my part in this. It doesn't help that this patch went through
several revisions. Is there a best practice for when to remove
signed-off-by or change authorship documented anywhere?
