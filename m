From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH 1/1] input: keyboard: Set configuration registers
Date: Fri, 9 Dec 2011 15:17:54 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17518605E5@HQMAIL01.nvidia.com>
References: <1323415758-16822-1-git-send-email-srasal@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1751860550@HQMAIL01.nvidia.com>
 <3849551.l2KNPKMSmh@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3849551.l2KNPKMSmh@dtor-d630.eng.vmware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shridhar Rasal <srasal@nvidia.com>, "rydberg@euromail.se" <rydberg@euromail.se>, Rakesh Iyer <riyer@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote at Friday, December 09, 2011 2:25 PM:
> On Friday, December 09, 2011 12:10:43 PM Stephen Warren wrote:
> > Shridhar Rasal wrote at Friday, December 09, 2011 12:29 AM:
> > > To: dmitry.torokhov@gmail.com
> > > Cc: rydberg@euromail.se; Stephen Warren; Rakesh Iyer;
> > > linux-kernel@vger.kernel.org; linux- input@vger.kernel.org;
> > > linux-tegra@vger.kernel.org; Shridhar Rasal Subject: [PATCH 1/1] input:
> > > keyboard: Set configuration registers
> > >
> > > -Set only REQUIRED row and column configuration register to
> > > PROPER values to avoid continuously generating KBC input events.
> > > -Use *en* field in pin_cfg, to check GPIO_x_ROW_EN register
> > > should be set or clear.
> > >
> > > Signed-off-by: Shridhar Rasal <srasal@nvidia.com>
> >
> > I wondered if num==0 could be used instead of a new en field, but 0 is a
> > valid row/column number, so no. As such,
> >
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Can we pass in number of pin_cfg instances in pdata and simply do not
> mention unneeded pins instead?

IIUC, the array is currently a fixed size (based on the set of pins
Supported by the KBC), hence that won't work; there's an entry for each
pin saying which row/column it is.

However, I suppose if we were to change the structure of the pdata to be:

struct tegra_kbc_pin_cfg {
    bool is_row;
    u8 row_col_id;
    u8 pin_id;
};

Then struct tegra_kbc_platform_data could indeed have a pointer to a
variable-sized array of these, which would avoid the "en" member.

-- 
nvpublic
