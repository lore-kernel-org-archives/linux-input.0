From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/8] Input: elan_i2c - add trackstick report
Date: Thu, 5 Apr 2018 16:46:32 -0700
Message-ID: <20180405234632.GA57189@dtor-ws>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
 <20180405132537.3218-4-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180405132537.3218-4-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Thu, Apr 05, 2018 at 03:25:32PM +0200, Benjamin Tissoires wrote:
> The Elan touchpads over I2C/SMBus also can handle a
> trackstick. Unfortunately, nothing tells us if the
> device supports trackstick (the information lies in
> the PS/2 node), so rely on a platform data to enable
> or not the trackstick node.

Hmm, I'd prefer if we did not add more platform data but rather user
generic device properties.

Thanks.

-- 
Dmitry
