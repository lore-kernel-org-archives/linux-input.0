From: Chen Yu <chenyu56@huawei.com>
Subject: =?UTF-8?Q?HID=ef=bc=9apanic_in_hid-betopff.c?=
Date: Mon, 13 Nov 2017 18:07:31 +0800
Message-ID: <79005d8a-6798-808e-4eb3-8374f9455bd6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:10528 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdKMKId (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Nov 2017 05:08:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, huangbobupt@163.com
Cc: wangbinghui@hisilicon.com

Hi，

There is a possible panic in function hid_betopff_play():

static int hid_betopff_play(struct input_dev *dev, void *data,
                         struct ff_effect *effect)
{
        struct hid_device *hid = input_get_drvdata(dev);
        struct betopff_device *betopff = data;
        __u16 left, right;

        left = effect->u.rumble.strong_magnitude;
        right = effect->u.rumble.weak_magnitude;

        betopff->report->field[2]->value[0] = left / 256;  /// betopff->report->field[2] could be NULL
        betopff->report->field[3]->value[0] = right / 256; /// so as betopff->report->field[3]

        hid_hw_request(hid, betopff->report, HID_REQ_SET_REPORT);

        return 0;
}

In function betopff_init(), calculation of "field_count" seems wrong:

static int betopff_init(struct hid_device *hid)
{
        struct betopff_device *betopff;
        struct hid_report *report;
        struct hid_input *hidinput =
                        list_first_entry(&hid->inputs, struct hid_input, list);
        struct list_head *report_list =
                        &hid->report_enum[HID_OUTPUT_REPORT].report_list;
        struct input_dev *dev = hidinput->input;
        int field_count = 0;
        int error;
        int i, j;

        if (list_empty(report_list)) {
                hid_err(hid, "no output reports found\n");
                return -ENODEV;
        }

        report = list_first_entry(report_list, struct hid_report, list);
        /*
         * Actually there are 4 fields for 4 Bytes as below:
         * -----------------------------------------
         * Byte0  Byte1  Byte2    Byte3
         * 0x00   0x00   left_motor right_motor
         * -----------------------------------------
         * Do init them with default value.
         */
        for (i = 0; i < report->maxfield; i++) {
                for (j = 0; j < report->field[i]->report_count; j++) {
                        report->field[i]->value[j] = 0x00;
                        field_count++;                      /// this line should out of this loop
                }
        }

        if (field_count < 4) {
                hid_err(hid, "not enough fields in the report: %d\n",
                                field_count);
                return -ENODEV;
        }

Do I misunderstand the code here?

Thanks and Regards
Yu Chen

