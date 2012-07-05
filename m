From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/8] HID-Sensors: Documentation
Date: Thu, 5 Jul 2012 02:56:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1207050243500.22508@pmeerw.net>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com> <1341431532-15060-2-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341431532-15060-2-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org
List-Id: linux-input@vger.kernel.org


nitpicking below

> Added a summary of HID sensor framework.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/hid/hid-sensor.txt |  139 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 139 insertions(+), 0 deletions(-)
>  create mode 100755 Documentation/hid/hid-sensor.txt
> 
> diff --git a/Documentation/hid/hid-sensor.txt b/Documentation/hid/hid-sensor.txt
> new file mode 100755
> index 0000000..a4b565f
> --- /dev/null
> +++ b/Documentation/hid/hid-sensor.txt
> @@ -0,0 +1,139 @@
> +
> +HID Sensors Framework
> +======================
> +HID sensor framework provides necessary interfaces to implement sensor drivers,
> +which are connected to a sensor hub. The sensor hub is HID device and it provides
is a HID device
> +a report descriptor confirming to HID 1.12 sensor usage tables.
conforming
> +
> +Description from the HID 1.12 "HID Sensor Usages" specification:
> +"Standardization of HID usages for sensors would allow (but not require) sensor
> +hardware vendors to provide a consistent Plug And Play interface at the USB boundary,
> +Thereby enabling some operating systems to incorporate common device drivers that
thereby
> +could be reused between vendors, alleviating any need for the vendors to provide
> +the drivers themselves."
> +
> +This specification describes many usage IDs, which describe the type of sensor
> +and also the individual data fields. Each sensor can have variable number of
> +data fields and length and order is specified in the report descriptor. For
maybe a comma after fields?
> +example a part of report descriptor can look like:
> +
> +   INPUT(1)[INPUT]
> + ..
> +    Field(2)
> +      Physical(0020.0073)
> +      Usage(1)
> +        0020.045f
> +      Logical Minimum(-32767)
> +      Logical Maximum(32767)
> +      Report Size(8)
> +      Report Count(1)
> +      Report Offset(16)
> +      Flags(Variable Absolute)
> +..
> +..
> +
> +The report is indicating "sensor page (0x20)" contains an accelerometer-3D (0x73).
> +This accelerometer-3D has some fields. Here for example field 2 is motion intensity
> +(0x045f) with a logical minimum value of -32767 and logical maximum of 32767. The
> +order of fields and length of each field is important as the input event raw
> +data will use this format.
> +
> +
> +Implementation
> +=================
> +
> +This specification defines many different types of sensors with different set of
sets
> +data fields. It is difficult to have a common input event to user space applications,
> +for different sensors. For example an accelerometer can send X,Y and Z data, whereas
> +an ambient light sensor can send illumination data. 
> +So the implementation has two parts:
> +- Core hid driver
> +- Individual sensor processing part (sensor drivers)
> +
> +Core driver
> +-----------
> +The core driver registers (hid-sensor-hub) registers as a HID driver. It parses
> +report descriptors and identifies all the sensors present. It adds an MFD device
> +with name HID-SENSOR-xxxx (where xxxx is usage id from the specification).
> +For example 
> +HID-SENSOR-200073 is registered for an Accelerometer 3D driver.
> +So if any driver with this name is inserted, then the probe routine for that
> +function will be called. So an accelerometer processing driver can register
> +with this name and will be probed if there is an accelerometer-3D is detected.
accelerometer-3D detected.
> +
> +The core driver provides a set of APIs which can be used by the processing
> +drivers to register and get events for that usage id. Also it provides a parsing
> +functions, get and set each input/feature/output report.
Also it provides parsing functions which get and set eaach 
input/feature/output report. ??
> +
> +Individual sensor processing part (sensor drivers)
> +-----------
> +The processing driver will use interface provided by core driver to parse
an interface provided by the core driver
> +the report and get the indexes of the fields and also can get events. This driver
> +can use IIO interface to use the standard ABI defined for a type of sensor.
> +
> +
> +Core driver Interface
> +=====================
> +
> +Callback structure:
> +Each processing driver can use this structure to set some callbacks.
> +	int (*suspend)(..): Callback when HID suspend is received
> +	int (*resume)(..): Callback when HID resume is received
> +	int (*capture_sample)(..): Capture a sample for one of its data field
fields
> +	int (*send_event)(..): One complete event is received which can have
> +                               multiple data fields. 
> +
> +
> +Registration functions:
> +int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id,
> +			struct hid_sensor_hub_callbacks *usage_callback):
> +
> +Registers callbacks for an usage id.
> +
> +
> +int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id):
> +
> +Removes callbacks for an usage id.
> +
> +
> +Parsing function:
> +int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
> +			u8 type,
> +			u32 usage_id, u32 attr_usage_id,
> +			struct hid_sensor_hub_attribute_info *info);
> +
> +A processing driver can look for some field of interest and check if it exists
> +in a report descriptor. If it exists the it will store necessary information
it exists it will
> +so that that field can be set or get individually.
so that fields
> +These indexes avoid searching every time and getting field index to get or set.
> +
> +
> +Set Feature report
> +int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +			u32 field_index, s32 value);
> +
> +This interface is used to set a value for a field in feature report. For example
> +if there is a field report_interval, which is parsed by a call to 
> +sensor_hub_input_get_attribute_info before, then it can directly set that individual
> +field.
> +
> +int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +			u32 field_index, s32 *value);
> +
> +
> +This interface is used to get a value for a field in input report. For example
> +if there is a field report_interval, which is parsed by a call to 
> +sensor_hub_input_get_attribute_info before, then it can directly get that individual
> +field value.
> +
> +int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id,
> +			u32 attr_usage_id, u32 report_id);
> +
> +This is used to get a particular field value through input reports. For example
> +accelerometer wants to poll X axis value, then it can call this function with
> +the usage id of X axis. HID sensors can provide events, so this is not necessary
> +to poll for any field. If there is some new sample, the core driver will call
> +registered callback function to process the sample.
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
