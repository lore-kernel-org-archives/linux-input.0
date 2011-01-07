From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 01/10] hid: add feature_mapping callback
Date: Fri, 7 Jan 2011 10:44:43 +0100
Message-ID: <AANLkTi=xdPJP9okhRL8q-0vL5cVPKniAjve6BQHmB=+p@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294248468-19979-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110106162223.GB1790@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110106162223.GB1790@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 6, 2011 at 5:22 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Wed, Jan 05, 2011 at 06:27:39PM +0100, Benjamin Tissoires wrote:
>> Currently hid doesn't export the features it knows to the specific m=
odules.
>> Some information can be really important in such features: MosArt an=
d
>> Cypress devices are by default not in a multitouch mode.
>> We have to send the value 2 on the right feature.
>>
>> This patch exports to the module the features report so they can fin=
d the
>> right feature to set up the correct mode.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/hid-input.c | =A0 10 +++++++++-
>> =A0include/linux/hid.h =A0 =A0 | =A0 =A04 ++++
>> =A02 files changed, 13 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index bb0b365..07d8cb2 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -287,6 +287,14 @@ static void hidinput_configure_usage(struct hid=
_input *hidinput, struct hid_fiel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (field->report_type =3D=3D HID_FEATURE_REPORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (device->driver->feature_mapping) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->driver->feature_ma=
pping(device, hidinput, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usa=
ge);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (device->driver->input_mapping) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D device->driver->input_mappin=
g(device, hidinput, field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage, &=
bit, &max);
>> @@ -836,7 +844,7 @@ int hidinput_connect(struct hid_device *hid, uns=
igned int force)
>> =A0 =A0 =A0 struct hid_input *hidinput =3D NULL;
>> =A0 =A0 =A0 struct input_dev *input_dev;
>> =A0 =A0 =A0 int i, j, k;
>> - =A0 =A0 int max_report_type =3D HID_OUTPUT_REPORT;
>> + =A0 =A0 int max_report_type =3D HID_FEATURE_REPORT;
>
> Doing it this way conflicts with the HID_QUIRK_SKIP_OUTPUT_REPORTS qu=
irk.


Do you agree on this way? (will send the patch in the next version)

@@ -834,11 +842,10 @@ int hidinput_connect(struct hid_device *hid,
unsigned int force)
 {
 	struct hid_report *report;
 	struct hid_input *hidinput =3D NULL;
 	struct input_dev *input_dev;
 	int i, j, k;
-	int max_report_type =3D HID_OUTPUT_REPORT;

 	INIT_LIST_HEAD(&hid->inputs);

 	if (!force) {
 		for (i =3D 0; i < hid->maxcollection; i++) {
@@ -851,14 +858,14 @@ int hidinput_connect(struct hid_device *hid,
unsigned int force)

 		if (i =3D=3D hid->maxcollection)
 			return -1;
 	}

-	if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
-		max_report_type =3D HID_INPUT_REPORT;
+	for (k =3D HID_INPUT_REPORT; k <=3D HID_FEATURE_REPORT; k++)
+		if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
+			continue;

-	for (k =3D HID_INPUT_REPORT; k <=3D max_report_type; k++)
 		list_for_each_entry(report, &hid->report_enum[k].report_list, list) =
{

 			if (!report->maxfield)
 				continue;

Cheers,
Benjamin
>
>>
>> =A0 =A0 =A0 INIT_LIST_HEAD(&hid->inputs);
>>
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index bb0f56f..75303b0 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -593,6 +593,7 @@ struct hid_usage_id {
>> =A0 * @report_fixup: called before report descriptor parsing (NULL m=
eans nop)
>> =A0 * @input_mapping: invoked on input registering before mapping an=
 usage
>> =A0 * @input_mapped: invoked on input registering after mapping an u=
sage
>> + * @feature_mapping: invoked on feature registering
>> =A0 * @suspend: invoked on suspend (NULL means nop)
>> =A0 * @resume: invoked on resume if device was not reset (NULL means=
 nop)
>> =A0 * @reset_resume: invoked on resume if device was reset (NULL mea=
ns nop)
>> @@ -636,6 +637,9 @@ struct hid_driver {
>> =A0 =A0 =A0 int (*input_mapped)(struct hid_device *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinp=
ut, struct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_usage *usage,=
 unsigned long **bit, int *max);
>> + =A0 =A0 void (*feature_mapping)(struct hid_device *hdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinput=
, struct hid_field *field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_usage *usage);
>> =A0#ifdef CONFIG_PM
>> =A0 =A0 =A0 int (*suspend)(struct hid_device *hdev, pm_message_t mes=
sage);
>> =A0 =A0 =A0 int (*resume)(struct hid_device *hdev);
>
> Thanks,
> Henrik
>
