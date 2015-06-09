From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v3 0/5] input: synaptics - report correct width and pressure values
Date: Tue, 09 Jun 2015 12:26:48 +0200
Message-ID: <11950935.CuRMW9jgUH@xps13>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37667 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbFIK07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 06:26:59 -0400
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de

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

Hi,

I'm sorry to bring this up again, but it's been a while.
Could this series be reviewed?

Thanks,
Gabriele
