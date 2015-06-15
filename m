From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH 2/7] input: cyapa: add gen6 device module support in
 driver
Date: Mon, 15 Jun 2015 02:34:57 +0000
Message-ID: <CY1PR06MB1817ACCA0F421A6F383D2FAFD1B80@CY1PR06MB1817.namprd06.prod.outlook.com>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
 <1434092198-13018-3-git-send-email-dudl@cypress.com>
 <20150613065645.GB5808@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bon0138.outbound.protection.outlook.com ([157.56.111.138]:29472
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751961AbbFODIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Jun 2015 23:08:13 -0400
In-Reply-To: <20150613065645.GB5808@hudson.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jeremiah,

Thanks for the review.

I will correct all the spelling errors you helped pointed out, and I will double check the spell, space and black line issues again.

Thanks,
Dudley

> -----Original Message-----
> From: Jeremiah Mahler [mailto:jmmahler@gmail.com]
> Sent: 2015?6?13? 14:57
> To: Dudley Du
> Cc: dmitry.torokhov@gmail.com; mark.rutland@arm.com; robh+dt@kernel.org;
> rydberg@euromail.se; bleung@google.com; devicetree@vger.kernel.org;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/7] input: cyapa: add gen6 device module support in driver
>
> Dudley,
>
> A few more spelling errors...
>
> On Fri, Jun 12, 2015 at 02:56:33PM +0800, Dudley Du wrote:
> > Based on the cyapa core, add the gen6 trackpad device's basic functions
> > supported, so gen6 trackpad device can work with kernel input system.
> > And also based on the state parse interface, the cyapa driver can
> > automatically determine the attached is gen3, gen5 or gen6 protocol
> > trackpad device, then set the correct protocol to work with the attached
> > trackpad device.
> > TEST=test on Chromebook.
> >
> > Signed-off-by: Dudley Du <dudl@cypress.com>
> > ---
> >  drivers/input/mouse/Makefile     |   2 +-
> >  drivers/input/mouse/cyapa.c      |  22 ++
> >  drivers/input/mouse/cyapa.h      |  15 +
> >  drivers/input/mouse/cyapa_gen5.c |  69 +++-
> >  drivers/input/mouse/cyapa_gen6.c | 729
> +++++++++++++++++++++++++++++++++++++++
> [...]
> > +static int cyapa_get_pip_fixed_info(struct cyapa *cyapa,
> > +struct pip_fixed_info *pip_info, bool is_bootloader)
> > +{
> > +u8 resp_data[PIP_READ_SYS_INFO_RESP_LENGTH];
> > +int resp_len;
> > +u16 product_family;
> > +int error;
> > +
> > +if (is_bootloader) {
> > +/* Read Bootlaoder Inforamtion to determine Gen5 or Gen6. */
>                        sp: ^^^^^^^^^^^
>
> > +resp_len = sizeof(resp_data);
> > +error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
> > +pip_get_bl_info, sizeof(pip_get_bl_info),
> > +resp_data, &resp_len,
> > +2000, cyapa_sort_tsg_pip_bl_resp_data,
> > +false);
> [...]
> > +
> > +product_family = get_unaligned_le16(&resp_data[7]);
> > +if ((product_family & PIP_PRODUCT_FAMILY_MASK) !=
> > +PIP_PRODUCT_FAMILY_TRACKPAD)
> > +return -EINVAL;
> > +
> > +pip_info->family_id = resp_data[19];
> > +pip_info->silicon_id_low = resp_data[21];
> > +pip_info->silicon_id_high = resp_data[22];
> > +
> > +return 0;
> > +
> > +}
> Why the extra blank line?
>
> > +
> > +int cyapa_pip_state_parse(struct cyapa *cyapa, u8 *reg_data, int len)
> > +{
> > +u8 cmd[] = { 0x01, 0x00};
> > +struct pip_fixed_info pip_info;
> > +u8 resp_data[PIP_HID_DESCRIPTOR_SIZE];
> > +int resp_len;
> > +bool is_bootloader;
> > +int error;
> > +
> > +cyapa->state = CYAPA_STATE_NO_DEVICE;
> > +
> > +/* Try to wake from it deep sleep state if it is. */
> > +cyapa_pip_deep_sleep(cyapa, PIP_DEEP_SLEEP_STATE_ON);
> > +
> > +/* Empty the buffer queue to get fresh data with later commands. */
> > +cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
> [...]
> > +static ssize_t cyapa_gen6_show_baseline(struct device *dev,
> > +struct device_attribute *attr, char *buf)
> > +{
> > +struct cyapa *cyapa = dev_get_drvdata(dev);
> > +u8 data[GEN6_MAX_RX_NUM];
> > +int data_len;
> > +int size = 0;
> > +int i;
> > +int error;
> > +int resume_error;
> > +
> > +if (!cyapa_is_pip_app_mode(cyapa))
> > +return -EBUSY;
> > +
> > +/* 1. Suspend Scanning*/
>                   space? ^^^
>
> > +error = cyapa_pip_suspend_scanning(cyapa);
> > +if (error)
> > +return error;
> > +
> > +/* 2. IDAC and RX Attenuator Calibration Data (Center Frequency). */
> > +data_len = sizeof(data);
> > +error = cyapa_pip_reterive_data_structure(cyapa, 0, data_len,
> > +GEN6_RETERIVE_DATA_ID_RX_ATTENURATOR_IDAC,
> > +data, &data_len);
> > +if (error)
> > +goto resume_scanning;
> > +
> > +size = scnprintf(buf, PAGE_SIZE, "%d %d %d %d %d %d ",
> > +data[0],  /* RX Attenuator Mutal */
> > +data[1],  /* IDAC Mutual */
> > +data[2],  /* RX Attenuator Self RX */
> > +data[3],  /* IDAC Self RX */
> > +data[4],  /* RX Attenuator Self TX */
> > +data[5]  /* IDAC Self TX */
> > +);
> > +
> > +/* 3. Read Attenuator Trim. */
> > +data_len = sizeof(data);
> > +error = cyapa_pip_reterive_data_structure(cyapa, 0, data_len,
> > +GEN6_RETERIVE_DATA_ID_ATTENURATOR_TRIM,
> > +data, &data_len);
> > +if (error)
> > +goto resume_scanning;
> > +
> > +/* set attenuator trim values. */
> > +for (i = 0; i < data_len; i++)
> > +size += scnprintf(buf + size, PAGE_SIZE - size,"%d ", data[i]);
> > +size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
> > +
> > +resume_scanning:
> > +/* 4. Resume Scanning*/
>                   space? ^^^
>
> > +resume_error = cyapa_pip_resume_scanning(cyapa);
> > +if (resume_error || error) {
> > +memset(buf, 0, PAGE_SIZE);
> > +return resume_error ? resume_error : error;
> > +}
> > +
> > +return size;
> > +}
> > +
> > +static int cyapa_gen6_operational_check(struct cyapa *cyapa)
> > +{
> > +struct device *dev = &cyapa->client->dev;
> > +int error;
> > +
> > +if (cyapa->gen != CYAPA_GEN6)
> > +return -ENODEV;
> > +
> > +switch (cyapa->state) {
> > +case CYAPA_STATE_GEN6_BL:
> > +error = cyapa_pip_bl_exit(cyapa);
> > +if (error) {
> > +/* Rry to update trackpad product information. */
>            sp: ^^^
>
> > +cyapa_gen6_bl_read_app_info(cyapa);
> > +goto out;
> > +}
> > +
> > +cyapa->state = CYAPA_STATE_GEN6_APP;
> > +
> > +case CYAPA_STATE_GEN6_APP:
> > +/*
> > + * If trackpad device in deep sleep mode,
> > + * the app command will fail.
> > + * So always try to reset trackpad device to full active when
> > + * the device state is requeried.
> > + */
> [...]
>
> --
> - Jeremiah Mahler

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
