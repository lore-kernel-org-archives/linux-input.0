From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add retry mechanism for reconnect
Date: Tue, 19 Feb 2013 10:50:26 -0800
Message-ID: <20130219185026.GB21103@core.coreip.homeip.net>
References: <1361176821-31372-1-git-send-email-cywang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361176821-31372-1-git-send-email-cywang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chung-yih Wang <cywang@chromium.org>
Cc: linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Seth Forshee <seth.forshee@canonical.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Chung-yih,

On Mon, Feb 18, 2013 at 04:40:21PM +0800, Chung-yih Wang wrote:
> On the Samsung Series 5 Chromebook, the Synaptics ClickPad will sometimes not
> send an "0xFA" PS/2 ACK in response to a command byte during the reconnect
> sequence following a resume from suspend. From our experiments, the failure can
> happen during any byte of any of the commands in the reconnect batch.
> 
> This failure results in a timeout in the psmouse driver. In addition, the
> ClickPad will often also respond to the next PS/2 command byte with an "0xFE"
> PS/2 RESEND response.

Since you control the firmware of the device can you figure out under
what condition the touchpad does not acknowledge the commands sent to it
and fix it there?

Thanks.

-- 
Dmitry
