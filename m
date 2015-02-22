From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v2 0/4] input: synaptics - report correct width and pressure values
Date: Sun, 22 Feb 2015 20:23:25 +0100
Message-ID: <5201835.ZKvczqpiaX@xps13>
References: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, oneukum@suse.de
List-Id: linux-input@vger.kernel.org

On Monday 05 January 2015 23:28:31 Gabriele Mazzotta wrote:
> Make image sensors and cr48 sensors report widths and fix the
> calculation of width and pressure values in some cases.
> 
> Changes since v1:
>  - Rebased on 35393dcb2ed3
>  - Get widths from AGM packets too
>  - Include support for cr48 sensors
>  - Fix pressure values on image sensors
> 
> Gabriele Mazzotta (4):
>   input: synaptics - fix pressure values calculation on image sensors
>   input: synaptics - fix width values calculation on image sensors
>   input: synaptics - change default width value of cr48 sensors
>   input: synaptics - make semi-mt touchpads report widths
> 
>  drivers/input/mouse/synaptics.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> 

Hi,

can this series be reviewed?

Regards,
Gabriele
