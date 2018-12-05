From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH v3 3/8] HID: core: process the Resolution Multiplier
Date: Wed,  5 Dec 2018 10:42:23 +1000
Message-ID: <20181205004228.10714-4-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The Resolution Multiplier is a feature report that modifies the value of
Usages within the same Logical Collection. If the multiplier is set to
anything but 1, the hardware reports (value * multiplier) for the same amount
of physical movement, i.e. the value we receive in the kernel is
pre-multiplied.

The hardware may either send a single (value * multiplier), or by sending
multiplier as many reports with the same value, or a combination of these two
options. For example, when the Microsoft Sculpt Ergonomic mouse Resolution
Multiplier is set to 12, the Wheel sends out 12 for every detent but AC Pan
sends out a value of 3 at 4 times the frequency.

The effective multiplier is based on the physical min/max of the multiplier
field, a logical min/max of [0,1] with a physical min/max of [1,8] means the
multiplier is either 1 or 8.

The Resolution Multiplier was introduced for high-resolution scrolling in
Windows Vista and is commonly used on Microsoft mice.

The recommendation for the Resolution Multiplier is to default to 1 for
backwards compatibility. This patch adds an arbitrary upper limit at 255. The
only known use case for the Resolution Multiplier is for scroll wheels where the
multiplier has to be a fraction of 120 to work with Windows.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes since v1, v2:
- expanded the commit message with more detail 

 drivers/hid/hid-core.c | 170 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h    |   5 ++
 2 files changed, 175 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 43d488a45120..f41d5fe51abe 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -294,6 +294,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 		field->usage[i].collection_index =
 			parser->local.collection_index[j];
 		field->usage[i].usage_index = i;
+		field->usage[i].resolution_multiplier = 1;
 	}
 
 	field->maxusage = usages;
@@ -947,6 +948,167 @@ struct hid_report *hid_validate_values(struct hid_device *hid,
 }
 EXPORT_SYMBOL_GPL(hid_validate_values);
 
+static int hid_calculate_multiplier(struct hid_device *hid,
+				     struct hid_field *multiplier)
+{
+	int m;
+	__s32 v = *multiplier->value;
+	__s32 lmin = multiplier->logical_minimum;
+	__s32 lmax = multiplier->logical_maximum;
+	__s32 pmin = multiplier->physical_minimum;
+	__s32 pmax = multiplier->physical_maximum;
+
+	/*
+	 * "Because OS implementations will generally divide the control's
+	 * reported count by the Effective Resolution Multiplier, designers
+	 * should take care not to establish a potential Effective
+	 * Resolution Multiplier of zero."
+	 * HID Usage Table, v1.12, Section 4.3.1, p31
+	 */
+	if (lmax - lmin == 0)
+		return 1;
+	/*
+	 * Handling the unit exponent is left as an exercise to whoever
+	 * finds a device where that exponent is not 0.
+	 */
+	m = ((v - lmin)/(lmax - lmin) * (pmax - pmin) + pmin);
+	if (unlikely(multiplier->unit_exponent != 0)) {
+		hid_warn(hid,
+			 "unsupported Resolution Multiplier unit exponent %d\n",
+			 multiplier->unit_exponent);
+	}
+
+	/* There are no devices with an effective multiplier > 255 */
+	if (unlikely(m == 0 || m > 255 || m < -255)) {
+		hid_warn(hid, "unsupported Resolution Multiplier %d\n", m);
+		m = 1;
+	}
+
+	return m;
+}
+
+static void hid_apply_multiplier_to_field(struct hid_device *hid,
+					  struct hid_field *field,
+					  struct hid_collection *multiplier_collection,
+					  int effective_multiplier)
+{
+	struct hid_collection *collection;
+	struct hid_usage *usage;
+	int i;
+
+	/*
+	 * If multiplier_collection is NULL, the multiplier applies
+	 * to all fields in the report.
+	 * Otherwise, it is the Logical Collection the multiplier applies to
+	 * but our field may be in a subcollection of that collection.
+	 */
+	for (i = 0; i < field->maxusage; i++) {
+		usage = &field->usage[i];
+
+		collection = &hid->collection[usage->collection_index];
+		while (collection && collection != multiplier_collection)
+			collection = collection->parent;
+
+		if (collection || multiplier_collection == NULL)
+			usage->resolution_multiplier = effective_multiplier;
+
+	}
+}
+
+static void hid_apply_multiplier(struct hid_device *hid,
+				 struct hid_field *multiplier)
+{
+	struct hid_report_enum *rep_enum;
+	struct hid_report *rep;
+	struct hid_field *field;
+	struct hid_collection *multiplier_collection;
+	int effective_multiplier;
+	int i;
+
+	/*
+	 * "The Resolution Multiplier control must be contained in the same
+	 * Logical Collection as the control(s) to which it is to be applied.
+	 * If no Resolution Multiplier is defined, then the Resolution
+	 * Multiplier defaults to 1.  If more than one control exists in a
+	 * Logical Collection, the Resolution Multiplier is associated with
+	 * all controls in the collection. If no Logical Collection is
+	 * defined, the Resolution Multiplier is associated with all
+	 * controls in the report."
+	 * HID Usage Table, v1.12, Section 4.3.1, p30
+	 *
+	 * Thus, search from the current collection upwards until we find a
+	 * logical collection. Then search all fields for that same parent
+	 * collection. Those are the fields the multiplier applies to.
+	 *
+	 * If we have more than one multiplier, it will overwrite the
+	 * applicable fields later.
+	 */
+	multiplier_collection = &hid->collection[multiplier->usage->collection_index];
+	while (multiplier_collection &&
+	       multiplier_collection->type != HID_COLLECTION_LOGICAL)
+		multiplier_collection = multiplier_collection->parent;
+
+	effective_multiplier = hid_calculate_multiplier(hid, multiplier);
+
+	rep_enum = &hid->report_enum[HID_INPUT_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		for (i = 0; i < rep->maxfield; i++) {
+			field = rep->field[i];
+			hid_apply_multiplier_to_field(hid, field,
+						      multiplier_collection,
+						      effective_multiplier);
+		}
+	}
+}
+
+/*
+ * hid_setup_resolution_multiplier - set up all resolution multipliers
+ *
+ * @device: hid device
+ *
+ * Search for all Resolution Multiplier Feature Reports and apply their
+ * value to all matching Input items. This only updates the internal struct
+ * fields.
+ *
+ * The Resolution Multiplier is applied by the hardware. If the multiplier
+ * is anything other than 1, the hardware will send pre-multiplied events
+ * so that the same physical interaction generates an accumulated
+ *	accumulated_value = value * * multiplier
+ * This may be achieved by sending
+ * - "value * multiplier" for each event, or
+ * - "value" but "multiplier" times as frequently, or
+ * - a combination of the above
+ * The only guarantee is that the same physical interaction always generates
+ * an accumulated 'value * multiplier'.
+ *
+ * This function must be called before any event processing and after
+ * any SetRequest to the Resolution Multiplier.
+ */
+void hid_setup_resolution_multiplier(struct hid_device *hid)
+{
+	struct hid_report_enum *rep_enum;
+	struct hid_report *rep;
+	struct hid_usage *usage;
+	int i, j;
+
+	rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		for (i = 0; i < rep->maxfield; i++) {
+			/* Ignore if report count is out of bounds. */
+			if (rep->field[i]->report_count < 1)
+				continue;
+
+			for (j = 0; j < rep->field[i]->maxusage; j++) {
+				usage = &rep->field[i]->usage[j];
+				if (usage->hid == HID_GD_RESOLUTION_MULTIPLIER)
+					hid_apply_multiplier(hid,
+							     rep->field[i]);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(hid_setup_resolution_multiplier);
+
 /**
  * hid_open_report - open a driver-specific device report
  *
@@ -1043,9 +1205,17 @@ int hid_open_report(struct hid_device *device)
 				hid_err(device, "unbalanced delimiter at end of report description\n");
 				goto err;
 			}
+
+			/*
+			 * fetch initial values in case the device's
+			 * default multiplier isn't the recommended 1
+			 */
+			hid_setup_resolution_multiplier(device);
+
 			kfree(parser->collection_stack);
 			vfree(parser);
 			device->status |= HID_STAT_PARSED;
+
 			return 0;
 		}
 	}
diff --git a/include/linux/hid.h b/include/linux/hid.h
index fdfda898656c..fd8d860365a4 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -219,6 +219,7 @@ struct hid_item {
 #define HID_GD_VBRZ		0x00010045
 #define HID_GD_VNO		0x00010046
 #define HID_GD_FEATURE		0x00010047
+#define HID_GD_RESOLUTION_MULTIPLIER	0x00010048
 #define HID_GD_SYSTEM_CONTROL	0x00010080
 #define HID_GD_UP		0x00010090
 #define HID_GD_DOWN		0x00010091
@@ -437,6 +438,8 @@ struct hid_usage {
 	unsigned  hid;			/* hid usage code */
 	unsigned  collection_index;	/* index into collection array */
 	unsigned  usage_index;		/* index into usage array */
+	__s8	  resolution_multiplier;/* Effective Resolution Multiplier
+					   (HUT v1.12, 4.3.1), default: 1 */
 	/* hidinput data */
 	__u16     code;			/* input driver code */
 	__u8      type;			/* input driver type */
@@ -894,6 +897,8 @@ struct hid_report *hid_validate_values(struct hid_device *hid,
 				       unsigned int type, unsigned int id,
 				       unsigned int field_index,
 				       unsigned int report_counts);
+
+void hid_setup_resolution_multiplier(struct hid_device *hid);
 int hid_open_report(struct hid_device *device);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
-- 
2.19.2
