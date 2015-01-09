From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v2 0/4] input: synaptics - report correct width and
 pressure values
Date: Fri, 09 Jan 2015 11:10:09 +0100
Message-ID: <1420798209.13007.8.camel@linux-0dmf.site>
References: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com
List-Id: linux-input@vger.kernel.org

On Mon, 2015-01-05 at 23:28 +0100, Gabriele Mazzotta wrote:
> Make image sensors and cr48 sensors report widths and fix the
> calculation of width and pressure values in some cases.
> 
> Changes since v1:
>  - Rebased on 35393dcb2ed3
>  - Get widths from AGM packets too
>  - Include support for cr48 sensors
>  - Fix pressure values on image sensors

Hi,

it seems to me that all these fixes should go into stable.

	Regards
		Oliver
