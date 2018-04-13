From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/9] Input: elan_i2c - add trackstick report
Date: Fri, 13 Apr 2018 12:36:52 -0500
Message-ID: <20180413173652.d5errnzdoz3elaes@rob-hp-laptop>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
 <20180409091051.2944-4-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409091051.2944-4-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 09, 2018 at 11:10:45AM +0200, Benjamin Tissoires wrote:
> The Elan touchpads over I2C/SMBus also can handle a
> trackstick. Unfortunately, nothing tells us if the
> device supports trackstick (the information lies in
> the PS/2 node), so rely on a platform data to enable
> or not the trackstick node.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1313939
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> changes in v2:
> - use of generic device property instead of platform data so
>   device tree can also make use of it
> ---
>  .../devicetree/bindings/input/elan_i2c.txt         |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/mouse/elan_i2c_core.c                | 90 +++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 3 deletions(-)
