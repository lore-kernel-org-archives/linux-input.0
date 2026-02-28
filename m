Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA99202F71;
	Sat, 28 Feb 2026 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250082; cv=none; b=fWb4489TKWJMxV31UTpLbilYvZoWMLc54i9rLxbx6Sjxa8ceNXaWjCvBUc6YHUbCIZFo39X3x2AzdYFEGSi0/7EFpcUAGWHGd9A5bCfFl58vcieXcaB4KNteYFA8xSWTbn1jBJrPhmN7+TH9zvTfIzsGWFFjm30I2vp/LK8WyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250082; c=relaxed/simple;
	bh=Q3Gk3ALc0whsrpSUs1MbFWAB6z20ELNKxj/3BmgjSZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvLM/fyRPT5o00msznacTeQFtCVjmx5gvNtWIlgyQOPcM4eiWMlSqmfTVGA7fxDa1f5IzvXPE4U9yrwyfhIA10x4op8rkg8ToJ4tpF3+AiqczjuS5CCgGd2duLPKRg964F9vDP1yPcQkcQq1PSUmsjQTODB3AQCZca7fY/rCs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACXKQ3VY6JpPQxLCQ--.26613S2;
	Sat, 28 Feb 2026 11:41:09 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: derekjohn.clark@gmail.com
Cc: mpearson-lenovo@squebb.ca,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] HID: hid-lenovo-go: Remove unneeded semicolon
Date: Sat, 28 Feb 2026 11:39:36 +0800
Message-Id: <20260228033936.285945-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXKQ3VY6JpPQxLCQ--.26613S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy8XrykZw15Jw4kKFyxAFb_yoWxJry8pF
	y7Aa90yFWUJrnrW3WSyrs8W343Kr97t3sxJ395GwnakanxJr98Ga4UJay0vry5ZF93Gw17
	GrWqvFWrZa4jyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjDPEDUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons after switch statements and function
bodies. Most issues were reported by Coccinelle/coccicheck using the
semantic patch at scripts/coccinelle/misc/semicolon.cocci. Additional
instances found during manual code review were also fixed.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/hid/hid-lenovo-go.c | 52 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 6972d13802e2..77e3823447e5 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -455,7 +455,7 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 	case FEATURE_IMU_BYPASS:
 		switch (cmd_rep->device_type) {
 		case LEFT_CONTROLLER:
@@ -466,7 +466,7 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 		break;
 	case FEATURE_LIGHT_ENABLE:
 		drvdata.rgb_en = cmd_rep->data[0];
@@ -481,7 +481,7 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 		break;
 	case FEATURE_TOUCHPAD_ENABLE:
 		drvdata.tp_en = cmd_rep->data[0];
@@ -515,7 +515,7 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 		break;
 	case RUMBLE_MODE:
 		switch (cmd_rep->device_type) {
@@ -527,7 +527,7 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
 			return 0;
 		default:
 			return -EINVAL;
-		};
+		}
 	case TP_VIBRATION_ENABLE:
 		drvdata.tp_vibration_en = cmd_rep->data[0];
 		return 0;
@@ -625,7 +625,7 @@ static int hid_go_os_mode_cfg_event(struct command_report *cmd_rep)
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static int hid_go_set_event_return(struct command_report *cmd_rep)
@@ -699,14 +699,14 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		default:
 			ret = -EINVAL;
 			break;
-		};
+		}
 		break;
 	case OS_MODE_DATA:
 		ret = hid_go_os_mode_cfg_event(cmd_rep);
 		break;
 	default:
 		goto passthrough;
-	};
+	}
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_PACKET_SIZE, data);
 
@@ -925,7 +925,7 @@ static ssize_t feature_status_store(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (ret < 0)
 		return ret;
@@ -1013,7 +1013,7 @@ static ssize_t feature_status_show(struct device *dev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 		count = sysfs_emit(buf, "%u\n", i);
 		break;
 	case FEATURE_FPS_SWITCH_STATUS:
@@ -1032,7 +1032,7 @@ static ssize_t feature_status_show(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return count;
 }
@@ -1070,7 +1070,7 @@ static ssize_t feature_status_options(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (count)
 		buf[count - 1] = '\n';
@@ -1111,7 +1111,7 @@ static ssize_t motor_config_store(struct device *dev,
 		ret = sysfs_match_string(intensity_text, buf);
 		val = ret;
 		break;
-	};
+	}
 
 	if (ret < 0)
 		return ret;
@@ -1161,7 +1161,7 @@ static ssize_t motor_config_show(struct device *dev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 		if (i >= ARRAY_SIZE(enabled_status_text))
 			return -EINVAL;
 
@@ -1177,7 +1177,7 @@ static ssize_t motor_config_show(struct device *dev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 		if (i >= ARRAY_SIZE(rumble_mode_text))
 			return -EINVAL;
 
@@ -1197,7 +1197,7 @@ static ssize_t motor_config_show(struct device *dev,
 
 		count = sysfs_emit(buf, "%s\n", intensity_text[i]);
 		break;
-	};
+	}
 
 	return count;
 }
@@ -1232,7 +1232,7 @@ static ssize_t motor_config_options(struct device *dev,
 					       enabled_status_text[i]);
 		}
 		break;
-	};
+	}
 
 	if (count)
 		buf[count - 1] = '\n';
@@ -1333,7 +1333,7 @@ static ssize_t device_status_show(struct device *dev,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (i >= ARRAY_SIZE(cal_status_text))
 		return -EINVAL;
@@ -1459,7 +1459,7 @@ static int rgb_attr_show(void)
 	index = drvdata.rgb_profile + 3;
 
 	return rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, index, 0, 0);
-};
+}
 
 static ssize_t rgb_effect_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -1489,7 +1489,7 @@ static ssize_t rgb_effect_store(struct device *dev,
 
 	drvdata.rgb_effect = effect;
 	return count;
-};
+}
 
 static ssize_t rgb_effect_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -1552,7 +1552,7 @@ static ssize_t rgb_speed_store(struct device *dev,
 	drvdata.rgb_speed = val;
 
 	return count;
-};
+}
 
 static ssize_t rgb_speed_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -1594,7 +1594,7 @@ static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
 	drvdata.rgb_mode = val;
 
 	return count;
-};
+}
 
 static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -1609,7 +1609,7 @@ static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%s\n", rgb_mode_text[drvdata.rgb_mode]);
-};
+}
 
 static ssize_t rgb_mode_index_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -1649,7 +1649,7 @@ static ssize_t rgb_profile_store(struct device *dev,
 	drvdata.rgb_profile = val;
 
 	return count;
-};
+}
 
 static ssize_t rgb_profile_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1665,7 +1665,7 @@ static ssize_t rgb_profile_show(struct device *dev,
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%hhu\n", drvdata.rgb_profile);
-};
+}
 
 static ssize_t rgb_profile_range_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -1704,7 +1704,7 @@ static void hid_go_brightness_set(struct led_classdev *led_cdev,
 		break;
 	default:
 		dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n", ret);
-	};
+	}
 }
 
 #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
-- 
2.25.1

