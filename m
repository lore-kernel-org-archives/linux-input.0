From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 2/9 v2] Input: synaptics - refactor agm packet parsing
Date: Fri, 22 Jul 2011 17:32:28 -0700
Message-ID: <4E2A169C.3070805@canonical.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org> <1311169146-20066-3-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:35680 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab1GWAce (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 20:32:34 -0400
In-Reply-To: <1311169146-20066-3-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On 07/20/2011 06:38 AM, djkurtz@chromium.org wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
> 
> When a Synaptics touchpad is in "AGM" mode, and multiple fingers are
> detected, the touchpad sends alternating "Advanced Gesture Mode" (AGM) and
> "Simple Gesture Mode" (SGM) packets.
>   The AGM packets have w=2, and contain reduced resolution finger data.
>   The SGM packets have w={0,1} and contain full resolution finger data.
> 
> Refactor the parsing of agm packets to its own function, and rename the
> synaptics_data.mt field to .agm to indicate that it contains the contents of
> the last agm packet.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Chase Douglas <chase.douglas@canonical.com>
