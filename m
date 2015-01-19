From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v18 09/12] input: cyapa: add gen5 trackpad device firmware
 update function support
Date: Mon, 19 Jan 2015 01:35:33 +0000
Message-ID: <BN1PR06MB070FC8E3B476865011A00EED14A0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
 <1421390055-32760-10-git-send-email-dudl@cypress.com>
 <20150119002634.GA23278@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150119002634.GA23278@dtor-glaptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "jmmahler@gmail.com" <jmmahler@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2015?1?19? 8:27
> To: Dudley Du
> Cc: jmmahler@gmail.com; rydberg@euromail.se; bleung@google.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v18 09/12] input: cyapa: add gen5 trackpad device firmware
> update function support
>
> On Fri, Jan 16, 2015 at 02:34:12PM +0800, Dudley Du wrote:
> > +/* APP_INTEGRITY row is always the last row block,
> > + * and the row id must be 0x01ff */
> > +row_num = get_unaligned_be16(
> > +&image->records[flash_records_count - 1].row_number);
> > +if (image->records[flash_records_count - 1].flash_array_id != 0x00 &&
> > +row_num != 0x01ff) {
>
> By the way, shouldn't this be "or" and not "and"?

It should or, thanks for the correction.

>
> > +dev_err(dev, "%s: invalid app_integrity data.\n", __func__);
> > +return -EINVAL;
> > +}
>
> Thanks.
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
