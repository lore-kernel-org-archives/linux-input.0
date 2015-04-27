From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v3 0/5] input: synaptics - report correct width and pressure values
Date: Mon, 27 Apr 2015 22:01:04 +0200
Message-ID: <13003016.tJqRYE8z3T@xps13>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de
List-Id: linux-input@vger.kernel.org

On Sunday 22 March 2015 15:43:51 Gabriele Mazzotta wrote:
> Hi,
> 
> I updated the series fixing the error reported by Shunsuke Shimizu that
> I made when I rebased v1. I've also included a change to make input
> devices correctly report their capabilities and included a change to
> make MT devices report widths as ABS_TOOL_WIDTH.
> 
> Gabriele Mazzotta (5):
>   input: synaptics - fix width values calculation on image sensors
>   input: synaptics - change default width value of cr48 sensors
>   input: synaptics - setup devices depending on their capabilities
>   input: synaptics - make image sensors and cr48 sensors report widths
>   input: MT - add ABS_TOOL_WIDTH to the legacy pointer emulation
> 
>  drivers/input/input-mt.c        | 12 +++++++--
>  drivers/input/mouse/synaptics.c | 55 +++++++++++++++++++++++++++--------------
>  2 files changed, 46 insertions(+), 21 deletions(-)
> 
> 

Hi Dmitry,

could you look into these?

Thanks,
Gabriele
