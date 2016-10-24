From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Mon, 24 Oct 2016 14:24:56 -0700
Message-ID: <20161024212456.GB24290@dtor-ws>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
 <20160707114101.GS29844@pali>
 <20160708213754.GF28589@dtor-ws>
 <201607091158.04008@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201607091158.04008@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Jul 09, 2016 at 11:58:03AM +0200, Pali Rohár wrote:
> On Friday 08 July 2016 23:37:54 Dmitry Torokhov wrote:
> > On Thu, Jul 07, 2016 at 01:41:01PM +0200, Pali Rohár wrote:
> > > On Tuesday 21 June 2016 13:27:30 Pali Rohár wrote:
> > > > On Monday 20 June 2016 17:31:13 Dmitry Torokhov wrote:
> > > > > Hi Pali,
> > > > > 
> > > > > On Mon, Jun 06, 2016 at 01:23:56PM +0200, Pali Rohár wrote:
> > > > > > This patch series cleanup usage of alps_model_data table.
> > > > > > 
> > > > > > Pali Rohár (5):
> > > > > >   Input: alps - move ALPS_PROTO_V6 out of alps_model_data
> > > > > >   table Input: alps - move ALPS_PROTO_V4 out of
> > > > > >   alps_model_data table Input: alps - move ALPS_PROTO_V1 out
> > > > > >   of alps_model_data table Input: alps - warn about
> > > > > >   unsupported ALPS V9 touchpad Input: alps - cleanup
> > > > > >   ALPS_PROTO_V2 detection
> > > > > 
> > > > > Frankly, I do not quite like this series. The rule of thumb we
> > > > > had: if we can use e7 data to identify the device it should go
> > > > > into table, if we need to have more elaborate logic - then
> > > > > implement it in __alps_indentify(). I would understand if we
> > > > > got rid of the table completely, but we didn't.
> > > > 
> > > > Hans and me agreed that alps_model_data array is for old
> > > > touchpads defined as quirks table. So in this patch series I'm
> > > > trying to eliminate using that array. And it is possible for V1,
> > > > V4 and V6 touchpads because each protocol has only one entry in
> > > > table. And last user is just V2 protocol which is I think
> > > > better...
> > > > 
> > > > So this is my motivation for this patch series.
> > > 
> > > Any suggestion how to rework it? And any agreement if we should
> > > remove V1/V4/V6 from alps_model_date or let it stay here?
> > 
> > As I mentioned below I am happy with removing ALPS_PROTO_V4 and
> > subsequently command_mode_resp from alps_model_info, while leaving
> > the rest in the table.
> 
> Now I'm not fully understand what you mean. This patch series does not 
> remove ALPS_PROTO_V4 support. Just move ALPS_PROTO_V4 out of 
> alps_model_info table structure (same as for V1 and V6). Field 
> command_mode_resp is removed from alps_model_info, but that can be done 
> only because command_mode_resp is used by ALPS_PROTO_V4 (which is moved 
> out of alps_model_info).
> 
> So I do not understand why do you think moving ALPS_PROTO_V4 out of 
> alps_model_info is good, but ALPS_PROTO_V6 or ALPS_PROTO_V1 not.

Quoting from my earlier email (you can see it a few lines above as well:

> > > > > Frankly, I do not quite like this series. The rule of thumb we 
> > > > > had: if we can use e7 data to identify the device it should go 
> > > > > into table, if we need to have more elaborate logic - then
> > > > > implement it in __alps_indentify(). I would understand if we
> > > > > got rid of the table completely, but we didn't.

I am OK with moving ALPS_PROTO_V4 out of the alps_model_data table
because it needs not only e7 response data, but also ec data, so moving
this protocol out of alps_model_data and writing custom comparison also
allows us to drop command_mode_resp field from alps_model_info
structure.

ALPS_PROTO_V1 and ALPS_PROTO_V6, just like ALPS_PROTO_V2, only need e7
response data. That is why I do not see the benefit of removing them
form the alps_model_data table and open-coding the comparison.

I hope this clears my position.

Thanks.

-- 
Dmitry
